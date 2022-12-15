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
  String toBePaid = '0.0';
  String totalPaid = '0.0';
  String totalAmount = '0.0';

  Future<void> getPaimentHistory(bool loader) async {
    var response;

    try {
      bool cacheExist =
          await APICacheManager().isAPICacheKeyExist('paymentHistory');
      if (loader) {
        hoverLoadingDialog(true);
      }
      loadingMembers = true;
      notifyListeners();
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
            var data = jsonDecode(res.body);
            var cacheModel =
                APICacheDBModel(key: 'paymentHistory', syncData: res.body);

            await APICacheManager().addCacheData(cacheModel);
            response = cacheModel.syncData;
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
        print("it's url Hit   ");
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
        if (response['data'] != 0) {
          // print("it's response Hit ${response}");
          // print("it's response Hit ${response['data']['data']}");

          totalAmount = response['total_payment'].toString();
          totalPaid = response['total_deposited'].toString();
          toBePaid = response['total_dues'].toString();
          payments.clear();
          response['data']['data'].forEach((e) {
            // print(e);
            payments.add(PaidPaymentsModel.fromJson(e));
            // totalPaid += PaidPaymentsModel.fromJson(e).amount ?? '0';
          });
        } else {
          total = response;
        }
      }
      if (loader) {
        hoverLoadingDialog(false);
      }
    } catch (e) {
      debugPrint('e e e e e e e -> $e');
      if (loader) {
        hoverLoadingDialog(false);
      }
    }

    print('testing PaidPayments History ------ >$total    ${payments.length}');
    loadingMembers = false;
    notifyListeners();
  }
}
