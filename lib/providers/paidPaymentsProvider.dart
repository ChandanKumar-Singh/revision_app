import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:revision/models/PaidPaymentsModel.dart';

import '../constants/app.dart';
import '../functions.dart';
import 'package:http/http.dart' as http;

class PaidPaymentsProvider extends ChangeNotifier {
  bool loadingMembers = false;
  List<PaidPaymentsModel> payments = <PaidPaymentsModel>[];
  int page = 1;
  int total = 0;
  double toBePaid = 0;
  double totalPaid = 0;

  Future<void> getTeam() async {
    var response;

    try {
      bool cacheExist =
          await APICacheManager().isAPICacheKeyExist('paymentHistory');
      hoverLoadingDialog(true);

      if (isOnline) {
        var url = '${App.baseUrl}${App.paymentHistory}?page=$page';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        page = 1;
        var res = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode({}));
        debugPrint(res.body);
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            var data = jsonDecode(res.body)['data'];
            var cacheModel = APICacheDBModel(
                key: 'paymentHistory', syncData: jsonEncode(data));

            await APICacheManager().addCacheData(cacheModel);
            response = cacheModel.syncData;
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
        print(
            "it's url Hit   ${jsonDecode(res.body)['data'] == 0 ? jsonDecode(res.body)['data'] : jsonDecode(res.body)['data']['total']} $response ");
      } else {
        showNetWorkToast();
        if (cacheExist) {
          response =
              (await APICacheManager().getCacheData('paymentHistory')).syncData;
          print("it's cache Hit $response");
        }
      }
      response = jsonDecode(response);
      if (response != null) {
        if (response != 0) {
          total = response['total'];
          payments.clear();
          response['data'].forEach((e) {
            payments.add(PaidPaymentsModel.fromJson(e));
            totalPaid+=double.parse(PaidPaymentsModel.fromJson(e).amount??'0');
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

    print('testing PaidPayments History ------ >$total    ${payments.length}');
    notifyListeners();
  }
}
