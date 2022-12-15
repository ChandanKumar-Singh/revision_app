import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/providers/AuthProvider.dart';
import 'package:revision/providers/ThemeProvider.dart';
import 'package:revision/providers/UserProvider.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../functions.dart';
import '../../providers/myIncomeProvider.dart';
import '../../providers/paidPaymentsProvider.dart';
import '../../widgets/cupPage.dart';
import '../../widgets/customToolTip.dart';
import '../../widgets/iconRefreshPage.dart';
import '../../widgets/imageRefreshPage.dart';
import 'HomeDrawer.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, up, _) {
      double heignt = Get.height;
      double weight = Get.width;

      return Consumer<ThemeProvider>(builder: (context, tp, _) {
        print(tp.themeMode);
        return Scaffold(
          key: _scaffoldKey,
          body: MyCustomUI(),
        );
      });
    });
  }
}

class MyCustomUI extends StatefulWidget {
  @override
  MyCustomUIState createState() => MyCustomUIState();
}

class MyCustomUIState extends State<MyCustomUI>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late ScrollController scrollController;
  bool scUp = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {
        if (scrollController.offset > 0) {
          scUp = true;
        } else {
          scUp = false;
        }
        print('hiiii  $scUp   $scrollController ');
      });
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    Provider.of<MyIncomeProvider>(context, listen: false).getReferralMembers();
    Provider.of<PaidPaymentsProvider>(context, listen: false)
        .getPaimentHistory(false);
    Provider.of<MyIncomeProvider>(context, listen: false).getGifts(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool checkingSales = false;
  bool checkingIncome = false;
  bool checkingWallet = false;
  bool showPrices = true;
  List<GiftCard> gifts = [
    GiftCard(giftName: 'Smart Phone', amount: 479000),
    GiftCard(giftName: 'Bike', amount: 559000),
    GiftCard(giftName: 'Laptop', amount: 700000),
    GiftCard(giftName: 'Bike', amount: 330000),
  ];
  bool refreshingHome = false;
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  Future<void> _handleRefresh() async {
    setState(() {
      refreshingHome = true;
    });
    try {
      await refreshThese()
          .then((value) => print('Refresh Successful! 😊'))
          .then((value) {
        // ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
        //     .showSnackBar(
        //   SnackBar(
        //     content: const Text('Refresh complete'),
        //     action: SnackBarAction(
        //       label: 'Refresh again',
        //       onPressed: () {
        //         _refreshIndicatorKey.currentState!.show();
        //       },
        //     ),
        //   ),
        // );
      });
    } catch (e) {
      // ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
      //   SnackBar(
      //     content: const Text('Refresh failed'),
      //     action: SnackBarAction(
      //       label: 'Refresh again',
      //       onPressed: () {
      //         _refreshIndicatorKey.currentState!.show();
      //       },
      //     ),
      //   ),
      // );
      Fluttertoast.showToast(msg: 'Refresh failed! 👎');

      print('refreshing error ---> $e');
    }
    Timer(const Duration(seconds: 1), () {
      setState(() {
        refreshingHome = false;
      });
    });
  }

  Future<void> refreshThese() async {
    if (isOnline) {
      Provider.of<AuthProvider>(context, listen: false).username.text =
          prefs.getString('username')!;
      Provider.of<AuthProvider>(context, listen: false).passController.text =
          prefs.getString('password')!;
      await Provider.of<MyIncomeProvider>(context, listen: false)
          .getReferralMembers();
      await Provider.of<UserProvider>(context, listen: false).getDashboard();
      await Provider.of<PaidPaymentsProvider>(context, listen: false)
          .getPaimentHistory(false);
      await Provider.of<MyIncomeProvider>(context, listen: false).getGifts(
          false); // await Provider.of<AuthProvider>(context, listen: false)
//     .login(imLogging: false);
      Fluttertoast.showToast(msg: 'Refresh Successful! 😊');
    } else {
      showNetWorkToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = Get.height;

    return Consumer<UserProvider>(builder: (context, up, _) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: HomeDrawer(
            scaffoldKey: _scaffoldKey,
            height: h,
            up: up,
            onChangeTheme: () {
              Timer(const Duration(milliseconds: 500), () {
                setState(() {});
              });
            }),
        bottomNavigationBar: Container(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Expanded(child: b1Text('Update is available')),
                    ElevatedButton(
                        onPressed: () async {
                          if (await canLaunchUrl(Uri.parse(
                              "https://play.google.com/store/apps/details?id=" +
                                  appPackageName))) {
                            print(Uri.parse(
                              "https://play.google.com/store/apps/details?id=" +
                                  appPackageName,
                            ));
                            await launchUrl(
                              Uri.parse(
                                "https://play.google.com/store/apps/details?id=" +
                                    appPackageName,
                              ),
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Could not launch Google Play Store');
                          }
                        },
                        child: const Text('Update')),
                  ],
                ),
              ),
              Container(),
            ],
          ),
        ),
        body: Scaffold(
          // backgroundColor: Colors.grey.withOpacity(scUp ? 0.7 : 0.7),
          extendBodyBehindAppBar: true,
          appBar: homeAppBar(context),

          // backgroundColor: const Color(0xff2A40CE),

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: LiquidPullToRefresh(
              key: _refreshIndicatorKey, // key if you want to add
              onRefresh: _handleRefresh,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Colors.white,
              height: kToolbarHeight + 70,
              child: ListView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Tooltip(
                        //   // message: 'Call Me',
                        //   richMessage:TextSpan(text: 'hhhhhhhhhhhh'),
                        //   triggerMode: TooltipTriggerMode.tap,
                        //   preferBelow: false,
                        //
                        //   child: ElevatedButton(
                        //
                        //     onPressed: () async {
                        //       const number = '+919135324545';
                        //       bool? res =
                        //           await FlutterPhoneDirectCaller.callNumber(number)
                        //               ;
                        //       print('res    $res   99999');
                        //     },
                        //     child: Text('call'),
                        //   ),
                        // ),
                        homeFirstRow(context),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            h6Text(
                              'Payments Details',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        homePaymentCircleCard(),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            h6Text(
                              'Gift Cards',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  homeGiftCardsList(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            h6Text(
                              'Monthly Overview',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(
                          height: 500,
                          child: BarChartSample1(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget homeGiftCardsList() {
    return Consumer<MyIncomeProvider>(builder: (context, mip, _) {
      return SizedBox(
        height: 210,
        child: !mip.loadingGifts
            ? SkeletonLoader(
                builder: SizedBox(
                  height: 210,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: 11,
                      itemBuilder: (context, i) {
                        return SizedBox(
                          width: 150,
                          child: Card(
                            elevation: 15,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(1),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                                topLeft: Radius.circular(7),
                                topRight: Radius.circular(100),
                              ),
                            ),
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text('                 ',
                                              maxLines: 3,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Get.theme.textTheme
                                                    .headline6!.fontSize,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: b1Text(
                                              'On Business of',
                                              maxLine: 3,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.currency_rupee_rounded,
                                        color: Colors.white,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: h6Text(
                                              '                       ',
                                              maxLine: 2,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                items: 1,
                period: const Duration(seconds: 3),
                highlightColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                direction: SkeletonDirection.ltr,
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                scrollDirection: Axis.horizontal,
                itemCount: mip.gifts.length,
                itemBuilder: (context, i) {
                  return SizedBox(
                    width: 150,
                    child: Card(
                      elevation: 15,
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7),
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(100),
                        ),
                      ),
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(mip.gifts[i].giftPack ?? '',
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Get.theme.textTheme
                                              .headline6!.fontSize,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: b1Text(
                                        'On Business of',
                                        maxLine: 3,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.currency_rupee_rounded,
                                  color: Colors.white,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: h6Text(
                                        oCcy.format(double.parse(
                                            mip.gifts[i].totalBusiness ?? '0')),
                                        maxLine: 2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      );
    });
  }

  Widget homePaymentCircleCard() {
    return Consumer<PaidPaymentsProvider>(builder: (context, ppp, _) {
      double total = double.parse(ppp.totalAmount.toString());
      double paid = double.parse(ppp.totalPaid.toString());
      double due = total - paid;
      String lastPaid = ppp.payments.isNotEmpty
          ? DateFormat('dd MMM yyyy')
              .format(DateTime.parse(ppp.payments.first.date!))
          : 'N/A';
      print('ppp ${ppp.loadingMembers}');
      // String lastPaid = 'foeyrey';
      return Card(
        elevation: 15,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(7),
            bottomRight: Radius.circular(7),
            topLeft: Radius.circular(7),
            topRight: Radius.circular(100),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ppp.loadingMembers
              ? SkeletonLoader(
                  builder: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      b1Text(
                                        'Total',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.currency_rupee_rounded,
                                            size: 15,
                                          ),
                                          b1Text(
                                            oCcy.format(total),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      b1Text(
                                        'Paid',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.currency_rupee_rounded,
                                            size: 15,
                                          ),
                                          b1Text(
                                            oCcy.format(paid),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: DashBoardCircleProgress(
                                total: total, paid: paid),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 5,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    b1Text(
                                      'Due',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee_rounded,
                                          size: 15,
                                        ),
                                        b1Text(
                                          oCcy.format(due),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 5,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    b1Text(
                                      'Last Paid',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          size: 15,
                                        ),
                                        const SizedBox(width: 5),
                                        b1Text(
                                          'dd-MM-yyyy',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  items: 1,
                  period: const Duration(seconds: 1),
                  highlightColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  direction: SkeletonDirection.ltr,
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 5,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    b1Text(
                                      'Total',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee_rounded,
                                          size: 15,
                                        ),
                                        b1Text(
                                          '$total',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: 5,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    b1Text(
                                      'Paid',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee_rounded,
                                          size: 15,
                                        ),
                                        b1Text(
                                          '$paid',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child:
                              DashBoardCircleProgress(total: total, paid: paid),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 5,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  b1Text(
                                    'Due',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee_rounded,
                                        size: 15,
                                      ),
                                      b1Text(
                                        '$due',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 5,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  b1Text(
                                    'Last Paid',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        size: 15,
                                      ),
                                      const SizedBox(width: 5),
                                      b1Text(
                                        lastPaid,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      );
    });
  }

  Row homeFirstRow(BuildContext context) {
    var up = Provider.of<UserProvider>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width / 3.3,
          child: GestureDetector(
            // onTap: () {
            //   setState(() {
            //     checkingIncome = !checkingIncome;
            //     if (checkingIncome) {
            //       checkingSales = false;
            //       checkingWallet = false;
            //     }
            //     if (checkingSales || checkingIncome || checkingWallet) {
            //       _height = 200;
            //     }
            //   });
            // },
            child: Tooltip(
              message: 'Income',
              triggerMode: TooltipTriggerMode.tap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width / 6,
                    child: Image.asset(
                      'assets/income.png',
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.currency_rupee_rounded,
                        size: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: b1Text(oCcy.format(up.totalDirect),
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width / 3.3,
          child: GestureDetector(
            // onTap: () {
            //   setState(() {
            //     checkingSales = !checkingSales;
            //     if (checkingSales) {
            //       checkingIncome = false;
            //       checkingWallet = false;
            //     }
            //     if (checkingSales || checkingIncome || checkingWallet) {
            //       // _height = 200;
            //     }
            //   });
            // },
            child: Tooltip(
              message: 'Sales',
              triggerMode: TooltipTriggerMode.tap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width / 6,
                    child: Image.asset(
                      'assets/sales.png',
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.currency_rupee_rounded,
                        size: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: b1Text(oCcy.format(up.totalReferral),
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width / 3.3,
          child: GestureDetector(
            // onTap: () {
            //   setState(() {
            //     checkingWallet = !checkingWallet;
            //     if (checkingWallet) {
            //       checkingIncome = false;
            //       checkingSales = false;
            //     }
            //     if (checkingSales || checkingIncome || checkingWallet) {
            //       _height = 200;
            //     }
            //   });
            // },
            child: Tooltip(
              message: 'Wallet',
              triggerMode: TooltipTriggerMode.tap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width / 7,
                    child: Image.asset(
                      'assets/wallet.png',
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.currency_rupee_rounded,
                        size: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: b1Text(oCcy.format(up.totalWallet),
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  PreferredSize homeAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight + 20),
      child: Card(
        margin: const EdgeInsets.all(0),
        shadowColor: scUp ? Colors.grey : Colors.transparent,
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(scUp ? 20 : 0)),
        ),
        color: scUp
            ? Theme.of(context).scaffoldBackgroundColor.withOpacity(01)
            : Theme.of(context).colorScheme.primary.withOpacity(0.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Menu',
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.menu,
                    color: refreshingHome
                        ? Colors.white
                        : Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    var fname = App.appname.split(' ').first;
                    var lnames = App.appname.split(' ');
                    lnames.removeAt(0);
                    var lname = lnames.join(' ');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        h5Text(
                          fname,
                          fontWeight: FontWeight.bold,
                          color: refreshingHome
                              ? Colors.white
                              : Theme.of(context).textTheme.headline6!.color,
                        ),
                        capText(
                          lname,
                          fontWeight: FontWeight.bold,
                          color: refreshingHome
                              ? Colors.white
                              : Theme.of(context).textTheme.headline6!.color,
                        ),
                      ],
                    );
                  }),
                ),
                Row(
                  children: [
                    h6Text(
                      DateFormat('dd MMM yyyy').format(DateTime.now()),
                      fontWeight: FontWeight.bold,
                      color: refreshingHome
                          ? Colors.white
                          : Theme.of(context).textTheme.headline6!.color,
                    ),
                  ],
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GiftCard {
  final String giftName;
  final double amount;
  GiftCard({required this.giftName, required this.amount});
}

class ContainerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    paint.color = Colors.green;

    path.moveTo(0, size.height * 0.9);
    path.quadraticBezierTo(
        0, size.height * 0.5, size.width * 0.2, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.9,
        size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.3,
        size.width * 0.65, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.3,
        size.width * 0.75, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.45,
        size.width * 0.85, size.height * .55);
    path.quadraticBezierTo(
        size.width * 0.95, size.height * 0.7, size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.9);
    canvas.drawPath(path, paint);
    final paint1 = Paint();
    paint1.style = PaintingStyle.fill;
    paint1.strokeWidth = 2;
    paint1.color = Colors.yellow;
    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * value).round(),
      (green * value).round(),
      (blue * value).round(),
    );
  }
}

class BarChartSample1 extends StatefulWidget {
  const BarChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  List<Color> get availableColors => const <Color>[
        Colors.purpleAccent,
        Colors.yellow,
        Colors.deepPurple,
        Colors.lightBlue,
        Colors.orange,
        Colors.pink,
        Colors.redAccent,
      ];

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Income',
                    style: TextStyle(
                      // color: Color(0xff0f4a3c),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Last 7 months overview',
                    style: TextStyle(
                      // color: Color(0xff379982),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: IconButton(
            //       icon: Icon(
            //         isPlaying ? Icons.pause : Icons.play_arrow,
            //         color: const Color(0xff0f4a3c),
            //       ),
            //       onPressed: () {
            //         setState(() {
            //           isPlaying = !isPlaying;
            //           if (isPlaying) {
            //             refreshState();
            //           }
            //         });
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Theme.of(context).colorScheme.primary : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary.darken())
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 30000,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 45544,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 35665,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 3655,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 93564,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 52016,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 36354,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      }).toList();

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            print(
                'month is ${DateTime.now().subtract(Duration(days: groupIndex * 31))}');

            String month = DateFormat('MMM yyyy').format(
                DateTime.now().subtract(Duration(days: (6 - groupIndex) * 31)));
            // switch (group.x) {
            //   case 0:
            //     weekDay = 'Monday';
            //     break;
            //   case 1:
            //     weekDay = 'Tuesday';
            //     break;
            //   case 2:
            //     weekDay = 'Wednesday';
            //     break;
            //   case 3:
            //     weekDay = 'Thursday';
            //     break;
            //   case 4:
            //     weekDay = 'Friday';
            //     break;
            //   case 5:
            //     weekDay = 'Saturday';
            //     break;
            //   case 6:
            //     weekDay = 'Sunday';
            //     break;
            //   default:
            //     throw Error();
            // }
            return BarTooltipItem(
              '$month\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: NumberFormat.simpleCurrency(name: 'INR')
                      .format(double.parse((rod.toY - 1).toString())),
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      // color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}

class DashBoardCircleProgress extends StatefulWidget {
  /// Creates the instance of MyHomePage
  DashBoardCircleProgress({Key? key, required this.total, required this.paid})
      : super(key: key);
  final double total;
  final double paid;
  @override
  _DashBoardCircleProgressState createState() =>
      _DashBoardCircleProgressState();
}

class _DashBoardCircleProgressState extends State<DashBoardCircleProgress> {
  late double progressValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressValue = (widget.paid / widget.total) * 100;
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
        minimum: 0, maximum: 150,
        // pointers: const <GaugePointer>[
        // RangePointer(
        //     value: 50,
        //     width: 0.1,
        //     sizeUnit: GaugeSizeUnit.factor,
        //     cornerStyle: CornerStyle.startCurve,
        //     gradient: SweepGradient(
        //         colors: <Color>[Color(0xFF00a9b5), Color(0xFFa4edeb)],
        //          stops: <double>[0.25, 0.75])),
        pointers: const <GaugePointer>[RangePointer(value: 20)],

        //     annotations: <GaugeAnnotation>[
        //   GaugeAnnotation(
        //       widget: Container(
        //         child: const Text(
        //           '90.0',
        //         ),
        //       ),
        //       angle: 90,
        //       positionFactor: 0.5)
        // ],
      ),
    ]);
  }

  Widget _getLinearGauge() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SfLinearGauge(
        minimum: 0.0,
        maximum: widget.total,
        orientation: LinearGaugeOrientation.horizontal,
        majorTickStyle: const LinearTickStyle(length: 20),
        axisLabelStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
        axisTrackStyle: const LinearAxisTrackStyle(
            color: Colors.cyan,
            edgeStyle: LinearEdgeStyle.bothFlat,
            thickness: 15.0,
            borderColor: Colors.grey),
      ),
    );
  }

  /// Returns normal style circular progress bars.
  Widget _getNormalProgressStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 120,
          width: 120,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: widget.total,
                showLabels: false,
                showTicks: false,
                radiusFactor: 0.8,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.2,
                  cornerStyle: CornerStyle.bothCurve,
                  color: Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      cornerStyle: CornerStyle.bothCurve,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0.1,
                      angle: 90,
                      widget: Text(
                        '${progressValue.toStringAsFixed(0)} / 100',
                        style: const TextStyle(fontSize: 11),
                      ))
                ])
          ]),
        ),
        Container(
          height: 120,
          width: 120,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.05,
                  color: Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      width: 0.05,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0,
                      widget: Text('${progressValue.toStringAsFixed(0)}%'))
                ])
          ]),
        ),
      ],
    );
  }

  /// Returns filled track style circular progress bar.
  Widget _getFilledTrackStyle() {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              axisLineStyle: const AxisLineStyle(
                thickness: 1,
                color: Color.fromARGB(255, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  value: progressValue,
                  width: 0.15,
                  enableAnimation: true,
                  animationDuration: 100,
                  color: Colors.white,
                  pointerOffset: 0.1,
                  cornerStyle: CornerStyle.bothCurve,
                  animationType: AnimationType.linear,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0.5,
                    widget: Text('${progressValue.toStringAsFixed(0)}%',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)))
              ])
        ]));
  }

  /// Returns filled progress style circular progress bar.
  Widget _getFilledProgressStyle() {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.8,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.05,
              color: Color.fromARGB(100, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: progressValue,
                width: 0.95,
                pointerOffset: 0.05,
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationType: AnimationType.linear,
                animationDuration: 100,
              )
            ],
          )
        ]));
  }

  /// Returns gradient progress style circular progress bar.
  Widget getGradientProgressStyle() {
    // print('progress value $progressValue');
    // print('progress value ${(widget.paid / widget.total)}');
    // print('progress value ${widget.paid}  ${widget.total}');
    return SizedBox(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              maximum: 100,
              minimum: 0,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.1,
                color: Color.fromARGB(30, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
                cornerStyle: CornerStyle.startCurve,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                    value: progressValue,
                    width: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationDuration: 100,
                    animationType: AnimationType.linear,
                    cornerStyle: CornerStyle.startCurve,
                    gradient: SweepGradient(colors: <Color>[
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ], stops: const <double>[
                      0.25,
                      0.75
                    ])),
                MarkerPointer(
                  value: progressValue,
                  markerType: MarkerType.circle,
                  enableAnimation: true,
                  animationDuration: 100,
                  animationType: AnimationType.linear,
                  color: const Color(0xFF87e8e8),
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0,
                    widget: Text('${progressValue.toStringAsFixed(0)}%'))
              ]),
        ]));
  }

  /// Returns thick progress style circular progress bar.
  Widget _getThickProgressStyle() {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.75,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.05,
              color: Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: progressValue,
                width: 0.2,
                pointerOffset: -0.08,
                enableAnimation: true,
                animationDuration: 100,
                animationType: AnimationType.linear,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ],
          )
        ]));
  }

  /// Returns semi-circular style circular progress bar.
  Widget _getSemiCircleProgressStyle() {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 180,
              canScaleToFit: true,
              endAngle: 0,
              radiusFactor: 0.8,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.1,
                color: Color.fromARGB(30, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
                cornerStyle: CornerStyle.startCurve,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                    value: progressValue,
                    width: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationDuration: 100,
                    animationType: AnimationType.linear,
                    cornerStyle: CornerStyle.startCurve)
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0,
                    widget: Text('${progressValue.toStringAsFixed(0)}%'))
              ]),
        ]));
  }

  /// Returns segmented line style circular progress bar.
  Widget _getSegmentedProgressStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 120,
            width: 120,
            child: SfRadialGauge(axes: <RadialAxis>[
              // Create primary radial axis
              RadialAxis(
                minimum: 0,
                interval: 1,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.2,
                  color: Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      width: 0.05,
                      pointerOffset: 0.07,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
              ),
              // Create secondary radial axis for segmented line
              RadialAxis(
                minimum: 0,
                interval: 1,
                maximum: 4,
                showLabels: false,
                showTicks: true,
                showAxisLine: false,
                tickOffset: -0.05,
                offsetUnit: GaugeSizeUnit.factor,
                minorTicksPerInterval: 0,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                majorTickStyle: const MajorTickStyle(
                    length: 0.3,
                    thickness: 3,
                    lengthUnit: GaugeSizeUnit.factor,
                    color: Colors.white),
              )
            ])),
        Container(
          height: 120,
          width: 120,
          child: SfRadialGauge(axes: <RadialAxis>[
            // Create primary radial axis
            RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                radiusFactor: 0.8,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.3,
                  color: Color.fromARGB(40, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      width: 0.3,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0.2,
                      horizontalAlignment: GaugeAlignment.center,
                      widget: Text('${progressValue.toStringAsFixed(0)}%'))
                ]),
            // Create secondary radial axis for segmented line
            RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              showAxisLine: true,
              tickOffset: -0.05,
              offsetUnit: GaugeSizeUnit.factor,
              minorTicksPerInterval: 0,
              radiusFactor: 0.8,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.3,
                color: Colors.white,
                dashArray: <double>[4, 3],
                thicknessUnit: GaugeSizeUnit.factor,
              ),
            )
          ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return getGradientProgressStyle();
  }
}

// class ToolTipCustomShape extends ShapeBorder {
//   final bool usePadding;
//   ToolTipCustomShape({this.usePadding = true});
//
//   @override
//   EdgeInsetsGeometry get dimensions =>
//       EdgeInsets.only(bottom: usePadding ? 20 : 0);
//
//   @override
//   Path getInnerPath(Rect rect, { TextDirection? textDirection })=>Path();
//
//   @override
//   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
//     rect =
//         Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 20));
//     return Path()
//       ..addRRect(
//           RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 3)))
//       ..moveTo(rect.bottomCenter.dx - 10, rect.bottomCenter.dy)
//       ..relativeLineTo(10, 20)
//       ..relativeLineTo(10, -20)
//       ..close();
//   }
//
//   @override
//   void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
//
//   @override
//   ShapeBorder scale(double t) => this;
// }
