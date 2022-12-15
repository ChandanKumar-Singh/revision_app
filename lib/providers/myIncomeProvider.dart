import 'dart:convert';
import 'dart:developer';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:revision/models/GiftModel.dart';
import 'package:revision/models/WithDrawModel.dart';
import 'package:revision/models/referalIncomeMOdel.dart';
import 'package:revision/models/referralMembers.dart';

import '../constants/app.dart';
import '../functions.dart';
import 'package:http/http.dart' as http;

enum DIHistoryType { directIncome, refIncomes, gifts }

enum IncomeType { direct, referral, gift }

class MyIncomeProvider extends ChangeNotifier {
  ///TODO:Received
  bool loadingDirIncome = false;
  List<DirectIncomeModel> dirIncomes = <DirectIncomeModel>[];
  int directIncomePage = 1;
  int totalDirIncome = 0;

  bool _isDiFirstLoadRunning = false;
  bool get isFirstLoadRunning => _isDiFirstLoadRunning;
  late ScrollController diScontroller;
  bool _hasDiNextPage = true;
  bool _isDiLoadMoreRunning = false;
  bool get isDiLoadMoreRunning => _isDiLoadMoreRunning;
  set isDiLoadMoreRunning(val) => _isDiLoadMoreRunning = val;

  Future<void> getDirIncomes() async {
    var response;
    directIncomePage = 1;

    try {
      bool cacheExist =
          await APICacheManager().isAPICacheKeyExist('directIncome');
      hoverLoadingDialog(true);

      if (isOnline) {
        var url = '${App.baseUrl}${App.directIncome}?page=$directIncomePage';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        var res =
            await http.post(Uri.parse(url), headers: headers, body: filterData);
        debugPrint('directIncome parameters $filterData');
        debugPrint(res.body);
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            var data = jsonDecode(res.body)['data'];
            var cacheModel = APICacheDBModel(
                key: 'directIncome', syncData: jsonEncode(data));

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
              (await APICacheManager().getCacheData('directIncome')).syncData;
          print("it's cache Hit $response");
        }
      } else {
        showNetWorkToast();
      }
      response = jsonDecode(response);
      if (response != null) {
        print('response type is ${response.runtimeType}');
        if (response != 0) {
          totalDirIncome = response['total'];
          dirIncomes.clear();
          response['data'].forEach((e) {
            dirIncomes.add(DirectIncomeModel.fromJson(e));
            totalDirIncome += double.parse(e['direct_income']).floor();
          });
        } else {
          dirIncomes.clear();
          totalDirIncome = response;
        }
      }
      hoverLoadingDialog(false);
    } catch (e) {
      debugPrint('e e e e e e e -> $e');
      hoverLoadingDialog(false);
    }

    print('testing login ------ >$totalDirIncome    ${dirIncomes.length}');
    notifyListeners();
  }

  void diLoadMore() async {
    // print(
    //     'loading more  ${_hasNextPage == true} && ${_isFirstLoadRunning == false}&&   ${_isLoadMoreRunning == false} && ${controller.position.extentAfter < 50}');
    print(
        'extend di scroll Controller ${diScontroller.position.userScrollDirection}');
    if (_hasDiNextPage == true &&
        _isDiFirstLoadRunning == false &&
        _isDiLoadMoreRunning == false &&
        diScontroller.position.extentAfter < 300 &&
        diScontroller.position.userScrollDirection == ScrollDirection.reverse) {
      _isDiLoadMoreRunning = true; // Display a progress indicator at the bottom
      notifyListeners();
      directIncomePage += 1;
      notifyListeners(); // Increase _page by 1
      var url = '${App.baseUrl}${App.directIncome}?page=$directIncomePage';
      debugPrint('LoadMore Url : $url');
      final headers = {
        'Authorization-token': '3MPHJP0BC63435345341',
        'Authorization': 'Bearer ${prefs.getString('token')!}',
      };
      if (isOnline) {
        try {
          final response = await http.post(Uri.parse(url),
              headers: headers, body: filterData);
          var responseData = json.decode(response.body);
          if (response.statusCode == 200) {
            var success = responseData['success'];

            if (responseData != null) {
              print('response type is ${responseData.runtimeType}');
              if (responseData['data'] != 0) {
                responseData['data']['data'].forEach((e) {
                  dirIncomes.add(DirectIncomeModel.fromJson(e));
                  totalDirIncome += double.parse(e['direct_income']).floor();
                  notifyListeners();
                });
              } else {
                Fluttertoast.showToast(msg: responseData['message']);
              }
              _isDiLoadMoreRunning = false;
              notifyListeners();
            }
          }
        } on NoSuchMethodError catch (err) {
          _isDiLoadMoreRunning = false;
          notifyListeners();
          log(err.toString());
          Fluttertoast.showToast(
            msg: 'Something wrong.',
          );
        }
      } else {
        showNetWorkToast();
      }

      _isDiLoadMoreRunning = false;
      notifyListeners();
    }
  }

  ///TODO:Referral Income
  bool loadingRefIncomes = false;
  List<ReferralIncomeModel> refIncomes = <ReferralIncomeModel>[];
  List<ReferralIncomeModel> newRefIncomes = <ReferralIncomeModel>[];
  List<ReferralMember> refMembers = <ReferralMember>[];
  int refPage = 1;
  double totalRefIncomes = 0;
  int totalRefMembers = 0;
  ReferralMember? selectedMember;
  int? selectedType;

  bool _isRfFirstLoadRunning = false;
  bool get isRfFirstLoadRunning => _isRfFirstLoadRunning;
  late ScrollController rfScontroller;
  bool _hasRfNextPage = true;
  bool _isRfLoadMoreRunning = false;
  bool get isRfLoadMoreRunning => _isRfLoadMoreRunning;
  set isRfLoadMoreRunning(val) => _isRfLoadMoreRunning = val;
  void setSelectedMember(ReferralMember? member) {
    selectedMember = member;
    selectedType = null;
    notifyListeners();
    if (selectedMember != null &&
        refIncomes.any(
            (element) => element.directIncomes!.userId == selectedMember!.id)) {
      newRefIncomes.clear();
      newRefIncomes.add(refIncomes.firstWhere(
          (element) => element.directIncomes!.userId == selectedMember!.id));
      totalRefIncomes = 0;
      for (var element in newRefIncomes) {
        totalRefIncomes += double.parse(element.referralIncome ?? '0');
        notifyListeners();
      }
      notifyListeners();
    } else {
      newRefIncomes.clear();
      totalRefIncomes = 0;
      notifyListeners();
    }
    if (selectedMember != null) {
      print('selected member is ${selectedMember!.id}');
      print('selected member is ${selectedMember!.toJson()}');
      print('selected member is ${newRefIncomes.length}');
    } else {
      newRefIncomes.clear();
      newRefIncomes.addAll(refIncomes);
      totalRefIncomes = 0;
      for (var element in newRefIncomes) {
        totalRefIncomes += double.parse(element.referralIncome ?? '0');
        notifyListeners();
      }
      notifyListeners();
    }
    notifyListeners();
  }

  void setSelectedType(int? id) {
    selectedMember = null;
    selectedType = id;
    notifyListeners();
    if (selectedType != null &&
        refIncomes.any(
            (element) => element.directIncomes!.user!.designationId == id)) {
      newRefIncomes.clear();
      newRefIncomes.addAll(refIncomes.where(
          (element) => element.directIncomes!.user!.designationId == id));
      totalRefIncomes = 0;
      for (var element in newRefIncomes) {
        totalRefIncomes += double.parse(element.referralIncome ?? '0');
        notifyListeners();
      }
      notifyListeners();
    } else {
      newRefIncomes.clear();
      totalRefIncomes = 0;
      notifyListeners();
    }
    if (selectedType != null) {
      print('selected member is ${selectedType}');

      print('selected member is ${newRefIncomes.length}');
    } else {
      newRefIncomes.clear();
      newRefIncomes.addAll(refIncomes);
      totalRefIncomes = 0;
      selectedType = null;
      for (var element in newRefIncomes) {
        totalRefIncomes += double.parse(element.referralIncome ?? '0');
        notifyListeners();
      }
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> getRefIncomes() async {
    var response;
    refPage = 1;

    try {
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('refInc');
      hoverLoadingDialog(true);

      if (isOnline) {
        var url = '${App.baseUrl}${App.referralIncome}?page=$refPage';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        var res = await http.post(Uri.parse(url),
            headers: headers, body: filterData);
        debugPrint('requests parameters $filterData');
        // debugPrint(res.body);

        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            var data = jsonDecode(res.body)['data'];

            var cacheModel =
                APICacheDBModel(key: 'refInc', syncData: jsonEncode(data));

            await APICacheManager().addCacheData(cacheModel);
            response = cacheModel.syncData;
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
        print("it's referral url Hit ${res.body}");
      } else if (!isOnline && !filterApplied) {
        showNetWorkToast();
        if (cacheExist) {
          response = (await APICacheManager().getCacheData('refInc')).syncData;
          print("it's  referral cache Hit $response");
        }
      } else {
        showNetWorkToast();
      }
      response = jsonDecode(response);
      if (response != null) {
        print('response type is ${response.runtimeType}');

        if (response != 0) {
          // totalRefIncomes = response['total'];
          refIncomes.clear();
          newRefIncomes.clear();
          totalRefIncomes = 0;
          response['data'].forEach((e) {
            refIncomes.add(ReferralIncomeModel.fromJson(e));
            totalRefIncomes += double.parse(
                ReferralIncomeModel.fromJson(e).referralIncome ?? '0');
          });
          newRefIncomes.clear();
          newRefIncomes.addAll(refIncomes);
        } else {
          refIncomes.clear();
          newRefIncomes.clear();
          totalRefIncomes = 0;
        }
      }
      hoverLoadingDialog(false);
    } catch (e) {
      // print('response type is ${response.runtimeType}');

      debugPrint('e e e e e e e -> $e');
      hoverLoadingDialog(false);
    }

    print('testing login ------ >$totalRefIncomes    ${refIncomes.length}');
    notifyListeners();
  }

  void rfLoadMore() async {
    // print(
    //     'loading more  ${_hasNextPage == true} && ${_isFirstLoadRunning == false}&&   ${_isLoadMoreRunning == false} && ${controller.position.extentAfter < 50}');
    print(
        'extend di scroll Controller ${rfScontroller.position.userScrollDirection}');
    if (_hasRfNextPage == true &&
        _isRfFirstLoadRunning == false &&
        _isRfLoadMoreRunning == false &&
        rfScontroller.position.extentAfter < 300 &&
        rfScontroller.position.userScrollDirection == ScrollDirection.reverse) {
      _isRfLoadMoreRunning = true; // Display a progress indicator at the bottom
      notifyListeners();
      refPage += 1;
      notifyListeners(); // Increase _page by 1
      var url = '${App.baseUrl}${App.referralIncome}?page=$refPage';
      debugPrint('LoadMore Url : $url');
      final headers = {
        'Authorization-token': '3MPHJP0BC63435345341',
        'Authorization': 'Bearer ${prefs.getString('token')!}',
      };
      if (isOnline) {
        try {
          final response = await http.post(Uri.parse(url),
              headers: headers, body: filterData);
          print('response  is ${response.body}');
          var responseData = json.decode(response.body);
          if (response.statusCode == 200) {
            if (responseData != null) {
              print('response type is ${responseData.runtimeType}');
              if (responseData['success'] == 200) {
                if (responseData['data'] != 0) {
                  responseData['data']['data'].forEach((e) {
                    refIncomes.add(ReferralIncomeModel.fromJson(e));
                    totalRefIncomes +=
                        double.parse(e['plot_total_price']).floor();
                    notifyListeners();
                  });
                } else {
                  Fluttertoast.showToast(msg: responseData['message']);
                }
              }
              _isRfLoadMoreRunning = false;
              notifyListeners();
            }
          }
        } catch (err) {
          _isRfLoadMoreRunning = false;
          notifyListeners();
          log(err.toString());
          Fluttertoast.showToast(
            msg: 'Something wrong.',
          );
        }
      } else {
        showNetWorkToast();
      }

      _isRfLoadMoreRunning = false;
      notifyListeners();
    }
  }

  Future<void> getReferralMembers() async {
    var response;

    try {
      bool cacheExist =
          await APICacheManager().isAPICacheKeyExist('refMembers');
      // hoverLoadingDialog(true);

      if (isOnline) {
        var url = '${App.baseUrl}${App.getAllReferralTeamMembers}';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        refPage = 1;
        var res = await http.get(
          Uri.parse(url),
          headers: headers,
        );

        // debugPrint(res.body);

        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            var cacheModel =
                APICacheDBModel(key: 'refMembers', syncData: res.body);

            await APICacheManager().addCacheData(cacheModel);
            response = cacheModel.syncData;
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
      } else {
        showNetWorkToast();
      }
      response = jsonDecode(response);
      // print("response  -->$response");
      // print("response  -->${response.runtimeType}");
      if (response != null) {
        // print('response type is ${response.runtimeType}');
        // print('response type is ${response['data']}');

        if (response['data'] != 0) {
          totalRefMembers = response['count'];
          refMembers.clear();
          response['data'].forEach((e) {
            // print(e);
            refMembers.add(ReferralMember.fromJson(e));
          });
        } else {
          refMembers.clear();
          totalRefMembers = response;
        }
      }
      // hoverLoadingDialog(false);
    } catch (e) {
      // print('response type is ${response.runtimeType}');

      debugPrint('e e e e e e e getAllReferralTeamMembers -> $e');
      // hoverLoadingDialog(false);
    }

    print('testing login ------ >$totalRefMembers    ${refMembers.length}');
    notifyListeners();
  }

  ///TODO: gifts
  bool loadingGifts = false;
  List<GiftCard> gifts = <GiftCard>[];
  int giftPage = 1;
  int totalGifts = 0;

  bool _isGfFirstLoadRunning = false;
  bool get isGfFirstLoadRunning => _isGfFirstLoadRunning;
  late ScrollController gfScontroller;
  bool _hasGfNextPage = true;
  bool _isGfLoadMoreRunning = false;
  bool get isGfLoadMoreRunning => _isGfLoadMoreRunning;
  set isGfLoadMoreRunning(val) => _isGfLoadMoreRunning = val;

  Future<void> getGifts(bool loader) async {
    var response;

    try {
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('gifts');
      if (loader) {
        hoverLoadingDialog(true);
      }
      loadingGifts = true;
      notifyListeners();
      if (isOnline) {
        var url = '${App.baseUrl}${App.giftPacks}?page=$giftPage';
        var headers = {
          'Accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString('token')!}'
        };
        giftPage = 1;
        var res = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(filterData));
        debugPrint('gt gifts parameters $filterData');
        debugPrint('gt gifts res ${res.body}');
        // debugPrint(res.body);
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            var data = jsonDecode(res.body)['data'];
            var cacheModel =
                APICacheDBModel(key: 'gifts', syncData: jsonEncode(data));

            await APICacheManager().addCacheData(cacheModel);
            response = cacheModel.syncData;
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
        print("it's url Hit");
      } else if (!isOnline && !filterApplied) {
        showNetWorkToast();
        if (cacheExist) {
          response = (await APICacheManager().getCacheData('gifts')).syncData;
          print("it's cache Hit $response");
        }
      } else {
        showNetWorkToast();
      }
      response = jsonDecode(response);
      if (response != null) {
        if (response != 0) {
          totalGifts = response['total'];
          gifts.clear();
          response['data'].forEach((e) {
            gifts.add(GiftCard.fromJson(e));
          });
        } else {
          gifts.clear();
          totalGifts = response;
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

    print('testing get Gifts ------ >$totalGifts    ${gifts.length}');
    loadingGifts = true;
    notifyListeners();
  }

  void gfLoadMore() async {
    // print(
    //     'loading more  ${_hasNextPage == true} && ${_isFirstLoadRunning == false}&&   ${_isLoadMoreRunning == false} && ${controller.position.extentAfter < 50}');
    print(
        'extend gf scroll Controller ${gfScontroller.position.userScrollDirection}');
    if (_hasGfNextPage == true &&
        _isGfFirstLoadRunning == false &&
        _isGfLoadMoreRunning == false &&
        gfScontroller.position.extentAfter < 300 &&
        gfScontroller.position.userScrollDirection == ScrollDirection.reverse) {
      _isGfLoadMoreRunning = true; // Display a progress indicator at the bottom
      notifyListeners();
      giftPage += 1;
      notifyListeners(); // Increase _page by 1
      var url = '${App.baseUrl}${App.giftPacks}?page=$giftPage';
      debugPrint('_isGfLoadMoreRunning Url : $url');
      final headers = {
        'Authorization-token': '3MPHJP0BC63435345341',
        'Authorization': 'Bearer ${prefs.getString('token')!}',
      };
      if (isOnline) {
        try {
          final response = await http.post(Uri.parse(url),
              headers: headers, body: filterData);
          print('response  is ${response.body}');
          var responseData = json.decode(response.body);
          if (response.statusCode == 200) {
            if (responseData != null) {
              print('response type is ${responseData.runtimeType}');
              if (responseData['success'] == 200) {
                if (responseData['data'] != 0) {
                  responseData['data']['data'].forEach((e) {
                    gifts.add(GiftCard.fromJson(e));
                    notifyListeners();
                  });
                } else {
                  Fluttertoast.showToast(msg: responseData['message']);
                }
              }
              _isGfLoadMoreRunning = false;
              notifyListeners();
            }
          }
        } catch (err) {
          _isGfLoadMoreRunning = false;
          notifyListeners();
          log(err.toString());
          Fluttertoast.showToast(
            msg: 'Something wrong.',
          );
        }
      } else {
        showNetWorkToast();
      }

      _isGfLoadMoreRunning = false;
      notifyListeners();
    }
  }

  ///TODO:FilterWidget
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime toDate = DateTime.now();
  bool filterApplied = false;
  Map<String, dynamic> filterData = {};

  void searchWidget(
      {required String field, required BuildContext context}) async {
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

    print('testing login ------ >$totalGifts    ${gifts.length}');
    notifyListeners();
  }
}
