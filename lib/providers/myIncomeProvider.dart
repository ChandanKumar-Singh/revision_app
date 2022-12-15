import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:revision/models/WithDrawModel.dart';

import '../constants/app.dart';
import '../functions.dart';
import 'package:http/http.dart' as http;

enum HistoryType { received, request, withdrawal }

class PaymentsHistoryProvider extends ChangeNotifier {
  ///TODO:Received
  bool loadingReceived = false;
  List<WithDrawModel> receives = <WithDrawModel>[];
  int receivedPage = 1;
  int totalReceived = 0;

  Future<void> getReceived() async {
    var response;

    try {
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('received');
      hoverLoadingDialog(true);

      if (isOnline) {
        var url = '${App.baseUrl}${App.recievedPayments}?page=$receivedPage';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        receivedPage = 1;
        var res =
            await http.post(Uri.parse(url), headers: headers, body: filterData);
        debugPrint('received parameters $filterData');
        debugPrint(res.body);
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            var data = jsonDecode(res.body)['data'];
            var cacheModel =
                APICacheDBModel(key: 'received', syncData: jsonEncode(data));

            await APICacheManager().addCacheData(cacheModel);
            response = cacheModel.syncData;
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
        // print(
        //     "it's url Hit   ${jsonDecode(res.body)['data']['total']} $response ");
      } else if (!isOnline && !filterApplied) {
        showNetWorkToast();
        if (cacheExist) {
          response =
              (await APICacheManager().getCacheData('received')).syncData;
          print("it's cache Hit $response");
        }
      } else {
        showNetWorkToast();
      }
      response = jsonDecode(response);
      if (response != null) {
        print('response type is ${response.runtimeType}');
        if (response != 0) {
          totalReceived = response['total'];
          receives.clear();
          response['data'].forEach((e) {
            receives.add(WithDrawModel.fromJson(e));
          });
        } else {
          receives.clear();
          totalReceived = response;
        }
      }
      hoverLoadingDialog(false);
    } catch (e) {
      debugPrint('e e e e e e e -> $e');
      hoverLoadingDialog(false);
    }

    print('testing login ------ >$totalReceived    ${receives.length}');
    notifyListeners();
  }

  ///TODO:Requests
  bool loadingRequests = false;
  List<WithDrawModel> requests = <WithDrawModel>[];
  int requestsPage = 1;
  int totalRequests = 0;

  Future<void> getRequests() async {
    var response;

    try {
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('received');
      hoverLoadingDialog(true);

      if (isOnline) {
        var url = '${App.baseUrl}${App.requestedPayments}?page=$requestsPage';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        requestsPage = 1;
        var res =
            await http.post(Uri.parse(url), headers: headers, body: filterData);
        debugPrint('requests parameters $filterData');
        debugPrint(res.body);

        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            var data = jsonDecode(res.body)['data'];

            var cacheModel =
                APICacheDBModel(key: 'requests', syncData: jsonEncode(data));

            await APICacheManager().addCacheData(cacheModel);
            response = cacheModel.syncData;
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
        // print(
        //     "it's url Hit   ${jsonDecode(res.body)['data']['total']} $response ");
      } else if (!isOnline && !filterApplied) {
        showNetWorkToast();
        if (cacheExist) {
          response =
              (await APICacheManager().getCacheData('requests')).syncData;
          print("it's cache Hit $response");
        }
      } else {
        showNetWorkToast();
      }
      response = jsonDecode(response);
      if (response != null) {
        print('response type is ${response.runtimeType}');

        if (response != 0) {
          totalRequests = response['total'];
          requests.clear();
          response['data'].forEach((e) {
            requests.add(WithDrawModel.fromJson(e));
          });
        } else {
          requests.clear();
          totalRequests = response;
        }
      }
      hoverLoadingDialog(false);
    } catch (e) {
      // print('response type is ${response.runtimeType}');

      debugPrint('e e e e e e e -> $e');
      hoverLoadingDialog(false);
    }

    print('testing login ------ >$totalRequests    ${requests.length}');
    notifyListeners();
  }

  ///TODO: Withdrawal History
  bool loadingWithdrawal = false;
  List<WithDrawModel> withDraws = <WithDrawModel>[];
  int withdrawPage = 1;
  int totalWithdraw = 0;

  Future<void> getWithdraws() async {
    var response;

    try {
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('received');
      hoverLoadingDialog(true);

      if (isOnline) {
        var url = '${App.baseUrl}${App.withdrawalPayments}?page=$withdrawPage';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        withdrawPage = 1;
        var res =
            await http.post(Uri.parse(url), headers: headers, body: filterData);
        debugPrint('withdraw parameters $filterData');
        debugPrint(res.body);
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            var data = jsonDecode(res.body)['data'];
            var cacheModel =
                APICacheDBModel(key: 'received', syncData: jsonEncode(data));

            await APICacheManager().addCacheData(cacheModel);
            response = cacheModel.syncData;
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
        // print(
        //     "it's url Hit   ${jsonDecode(res.body)['data']['total']} $response ");
      } else if (!isOnline && !filterApplied) {
        showNetWorkToast();
        if (cacheExist) {
          response =
              (await APICacheManager().getCacheData('received')).syncData;
          print("it's cache Hit $response");
        }
      } else {
        showNetWorkToast();
      }
      response = jsonDecode(response);
      if (response != null) {
        if (response != 0) {
          totalWithdraw = response['total'];
          withDraws.clear();
          response['data'].forEach((e) {
            withDraws.add(WithDrawModel.fromJson(e));
          });
        } else {
          withDraws.clear();
          totalWithdraw = response;
        }
      }
      hoverLoadingDialog(false);
    } catch (e) {
      debugPrint('e e e e e e e -> $e');
      hoverLoadingDialog(false);
    }

    print('testing login ------ >$totalWithdraw    ${withDraws.length}');
    notifyListeners();
  }

  ///TODO:FilterWidget
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime toDate = DateTime.now();
  bool filterApplied = false;
  Map<String, dynamic> filterData = {};

  void searchWidget(
      {required List<WithDrawModel> list,
      required String field,
      required BuildContext context}) async {
    var dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now().add(const Duration(days: 1)));
    if (dt != null) {
      if (field == 'fd') {
        fromDate = dt;
      } else {
        toDate = dt;
      }
      print('filterData $filterData');
    }

    notifyListeners();
  }

  ///TODO:Apply request
  Future<bool> requestPayment(
      {required int amount, required String note}) async {
    try {
      hoverLoadingDialog(true);

      if (isOnline) {
        var url = '${App.baseUrl}${App.addPaymentRequest}';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        var body = {
          "requested_date": "",
          "requested_amount": amount.toString(),
          "user_comments": note
        };
        var res = await http.post(Uri.parse(url), headers: headers, body: body);
        debugPrint(res.body);
        if (res.statusCode == 200) {
          Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
        }
        return true;
      } else {
        showNetWorkToast();
        return false;
      }

      hoverLoadingDialog(false);
    } catch (e) {
      debugPrint('e e e e e e e -> $e');
      hoverLoadingDialog(false);
      return false;
    }

    print('testing login ------ >$totalWithdraw    ${withDraws.length}');
    notifyListeners();
  }
}
