import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:revision/models/TeamMemberModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app.dart';
import '../functions.dart';
import 'package:http/http.dart' as http;

class TeamProvider extends ChangeNotifier {
  bool loadingMembers = false;
  List<TeamMember> members = <TeamMember>[];
  int page = 1;
  int total = 0;

  Future<void> getTeam() async {
    var response;

    try {
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('team');
      hoverLoadingDialog(true);

      if (isOnline) {
        var url = '${App.baseUrl}${App.getTeamMembers}?page=$page';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        page = 1;
        var res = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode({}));
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            var data = jsonDecode(res.body)['data'];
            var cacheModel =
                APICacheDBModel(key: 'team', syncData: jsonEncode(data));

            await APICacheManager().addCacheData(cacheModel);
            response = cacheModel.syncData;
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
        print("it's url Hit $response");
      } else {
        showNetWorkToast();
        if (cacheExist) {
          response = (await APICacheManager().getCacheData('team')).syncData;
          print("it's cache Hit $response");
        }
      }
      response = jsonDecode(response);
      if (response != null) {
        if (response != 0) {
          total = response['total'];
          members.clear();
          response['data'].forEach((e) {
            members.add(TeamMember.fromJson(e));
          });
        } else {
          total = response;
        }
      }
      hoverLoadingDialog(false);

    } catch (e) {
      debugPrint('e e e e e e e -> $e');
      hoverLoadingDialog(false);

    }

    print('testing login ------ >$total    ${members.length}');
    notifyListeners();
  }
}
