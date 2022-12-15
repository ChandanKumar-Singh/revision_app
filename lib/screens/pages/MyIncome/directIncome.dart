import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/providers/myIncomeProvider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../functions.dart';

class DirectIncome extends StatefulWidget {
  const DirectIncome({Key? key}) : super(key: key);

  @override
  _DirectIncomeState createState() => _DirectIncomeState();
}

class _DirectIncomeState extends State<DirectIncome> {
  String? choiceChipsValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer timer;
  bool isConcave = false;
  void init() async {
    var mip = Provider.of<MyIncomeProvider>(context, listen: false);
    mip.dirIncomes.clear();
    mip.totalDirIncome = 0;
    mip.loadingDirIncome = false;
    mip.filterApplied = false;
    mip.filterData.clear();
    mip.fromDate = DateTime.now().subtract(const Duration(days: 1));
    mip.toDate = DateTime.now();
    await mip.getDirIncomes();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        isConcave = !isConcave;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

    Provider.of<MyIncomeProvider>(context, listen: false).diScontroller =
        ScrollController()
          ..addListener(
              Provider.of<MyIncomeProvider>(context, listen: false).diLoadMore);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Provider.of<MyIncomeProvider>(context, listen: false)
        .diScontroller
        .removeListener(
            Provider.of<MyIncomeProvider>(context, listen: false).diLoadMore);
    timer.cancel();
    super.dispose();
  }

  Future<bool> willPop() async {
    var mip = Provider.of<MyIncomeProvider>(context, listen: false);
    mip.dirIncomes.clear();
    mip.totalDirIncome = 0;
    mip.loadingDirIncome = false;
    mip.filterApplied = false;
    mip.filterData.clear();
    mip.fromDate = DateTime.now().subtract(const Duration(days: 1));
    mip.toDate = DateTime.now();
    debugPrint('On will pop withdraws length ${mip.dirIncomes.length} ');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Consumer<MyIncomeProvider>(builder: (context, mip, _) {
        return Scaffold(
          key: scaffoldKey,
          // backgroundColor: Theme.of(context).textTheme.primaryBackground,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: SizedBox(
                // width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          // borderColor: Colors.transparent,
                          // borderRadius: 30,
                          // borderWidth: 1,
                          // buttonSize: 60,
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            size: 30,
                          ),
                          onPressed: () async {
                            Get.back();
                          },
                        ),
                        Text(
                          'Direct Income',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const MIDateFilterSheet(
                                      type: IncomeType.direct,
                                    );
                                  });
                            },
                            icon: Stack(
                              children: [
                                const Icon(Icons.filter_list),
                                if (mip.filterApplied)
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      height: 7,
                                      width: 7,
                                    ),
                                  ),
                              ],
                            )),
                        // IconButton(
                        //   // borderColor: Colors.transparent,
                        //   // borderRadius: 30,
                        //   // borderWidth: 1,
                        //   // buttonSize: 60,
                        //   icon: Icon(
                        //     Icons.search_rounded,
                        //     color: Theme.of(context).textTheme.bodyText1!.color,
                        //     size: 30,
                        //   ),
                        //   onPressed: () {
                        //     print('IconButton pressed ...');
                        //   },
                        // ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.currency_rupee_rounded),
                                          Text(
                                            oCcy.format(mip.totalDirIncome),
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                  fontFamily: 'Lora',
                                                  letterSpacing: 2,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Stack(
                                children: [
                                  ListView.builder(
                                    controller: mip.diScontroller,
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 10),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: mip.dirIncomes.length,
                                    itemBuilder: (context, i) {
                                      var income = mip.dirIncomes[i];
                                      var fromDate = DateFormat('MMM dd, yyyy')
                                          .format(
                                              DateTime.parse(income.fromDate!));
                                      var toDate = DateFormat('MMM dd, yyyy')
                                          .format(
                                              DateTime.parse(income.toDate!));
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, i == 0 ? 20 : 5, 0, 16),
                                        child: Card(
                                          elevation: 7,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        12, 10, 12, 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(0.9),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 3),
                                                        child: b1Text(
                                                          fromDate,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .primary
                                                              .withOpacity(0.9),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        0),
                                                            child: h6Text('-',
                                                                color: Colors
                                                                    .white))),
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .primary
                                                              .withOpacity(0.9),
                                                        ),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        5),
                                                            child: b1Text(
                                                                toDate,
                                                                color: Colors
                                                                    .white))),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            12, 0, 12, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          4),
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .award,
                                                                size: 20,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      4,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                ' Level  ${income.level ?? ''}',
                                                                style: Get
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                  fontFamily:
                                                                      'Lexend Deca',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Neumorphic(
                                                          style:
                                                              NeumorphicStyle(
                                                            shape: isConcave
                                                                ? NeumorphicShape
                                                                    .convex
                                                                : NeumorphicShape
                                                                    .concave,
                                                            boxShape: NeumorphicBoxShape
                                                                .roundRect(
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            depth: !isConcave
                                                                ? -5
                                                                : 5,
                                                            // intensity: 10,
                                                            // lightSource: LightSource.topLeft,
                                                            // color: Colors.blue
                                                          ),
                                                          drawSurfaceAboveChild:
                                                              true,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: h6Text(
                                                                '${income.percentage}%',
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            12, 0, 12, 4),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          'Total Sale :',
                                                          style: Get.textTheme
                                                              .bodyText1,
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '₹',
                                                                      style: Get
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: Get
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .color,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      oCcy.format(double.parse(
                                                                          income.totalSale ??
                                                                              '0')),
                                                                      style: Get
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: Get
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .color,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            12, 4, 12, 4),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          'Total Received :',
                                                          style: Get.textTheme
                                                              .bodyText1,
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '₹',
                                                                      style: Get
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: Get
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .color,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      oCcy.format(double.parse(
                                                                          income.totalReceived ??
                                                                              '0')),
                                                                      style: Get
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: Get
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .color,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            12, 4, 12, 12),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          'Direct Income :',
                                                          style: Get.textTheme
                                                              .bodyText1,
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '₹',
                                                                      style: Get
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: Get
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .color,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      oCcy.format(double.parse(
                                                                          income.directIncome ??
                                                                              '0')),
                                                                      style: Get
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                        fontFamily:
                                                                            'Lexend Deca',
                                                                        color: Get
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .color,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
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
                                    },
                                  ),
                                  if (mip.isDiLoadMoreRunning)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 18.0),
                                            child: CupertinoActivityIndicator(),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                              // return ListView.builder(
                              //   padding: EdgeInsets.zero,
                              //   shrinkWrap: true,
                              //   scrollDirection: Axis.vertical,
                              //   itemCount: paidPaymentHisCard.length,
                              //   itemBuilder:
                              //       (context, paidPaymentHisCardIndex) {
                              //     final paidPaymentHisCardItem =
                              //         paidPaymentHisCard[
                              //             paidPaymentHisCardIndex];
                              //     return Container(
                              //       padding: const EdgeInsetsDirectional
                              //           .fromSTEB(0, 10, 1, 0),
                              //       margin: const EdgeInsetsDirectional
                              //           .fromSTEB(0, 0, 1, 10),
                              //       width: double.infinity,
                              //       // height: 100,
                              //       decoration: BoxDecoration(
                              //         color: Theme.of(context).cardColor,
                              //         boxShadow: const [
                              //           BoxShadow(
                              //             blurRadius: 4,
                              //             color: Color(0x33000000),
                              //             offset: Offset(1, 2),
                              //           )
                              //         ],
                              //         borderRadius:
                              //             BorderRadius.circular(10),
                              //       ),
                              //       child: Padding(
                              //         padding: const EdgeInsetsDirectional
                              //             .fromSTEB(0, 0, 0, 0),
                              //         child: Column(
                              //           mainAxisSize: MainAxisSize.max,
                              //           children: [
                              //             Row(
                              //               mainAxisSize: MainAxisSize.max,
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.end,
                              //               children: [
                              //                 Padding(
                              //                   padding:
                              //                       const EdgeInsetsDirectional
                              //                           .fromSTEB(
                              //                               0, 0, 10, 0),
                              //                   child: Text(
                              //                     '241 Sales',
                              //                     style: Theme.of(context)
                              //                         .textTheme
                              //                         .bodyText2!
                              //                         .copyWith(
                              //                             color:
                              //                                 Colors.blue),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //             Row(
                              //               mainAxisSize: MainAxisSize.max,
                              //               children: [
                              //                 Padding(
                              //                   padding:
                              //                       const EdgeInsetsDirectional
                              //                               .fromSTEB(
                              //                           10, 0, 0, 0),
                              //                   child: Container(
                              //                     width: 30,
                              //                     height: 30,
                              //                     clipBehavior:
                              //                         Clip.antiAlias,
                              //                     decoration: const BoxDecoration(
                              //                       shape: BoxShape.circle,
                              //                     ),
                              //                     child: !isOnline
                              //                         ? Image.network(
                              //                             'https://picsum.photos/seed/901/600',
                              //                             fit: BoxFit.cover,
                              //                           )
                              //                         : Image.asset(
                              //                             'assets/user.png'),
                              //                   ),
                              //                 ),
                              //                 Expanded(
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsetsDirectional
                              //                                 .fromSTEB(
                              //                             10, 0, 0, 0),
                              //                     child: Row(
                              //                       mainAxisSize:
                              //                           MainAxisSize.max,
                              //                       children: [
                              //                         Expanded(
                              //                           child: Column(
                              //                             mainAxisSize:
                              //                                 MainAxisSize
                              //                                     .max,
                              //                             crossAxisAlignment:
                              //                                 CrossAxisAlignment
                              //                                     .start,
                              //                             children: [
                              //                               Text(
                              //                                 'Chandan Kumar Singh',
                              //                                 style: Theme.of(
                              //                                         context)
                              //                                     .textTheme
                              //                                     .bodyText1,
                              //                               ),
                              //                               Padding(
                              //                                 padding:
                              //                                     const EdgeInsetsDirectional
                              //                                             .fromSTEB(
                              //                                         0,
                              //                                         0,
                              //                                         10,
                              //                                         0),
                              //                                 child: Row(
                              //                                   mainAxisSize:
                              //                                       MainAxisSize
                              //                                           .max,
                              //                                   mainAxisAlignment:
                              //                                       MainAxisAlignment
                              //                                           .spaceBetween,
                              //                                   children: [
                              //                                     Row(
                              //                                       children: [
                              //                                         const Icon(
                              //                                           Icons.currency_rupee_rounded,
                              //                                           size:
                              //                                               15,
                              //                                         ),
                              //                                         Text(
                              //                                           '${1509.80}',
                              //                                           style:
                              //                                               Theme.of(context).textTheme.bodyText1,
                              //                                         ),
                              //                                       ],
                              //                                     ),
                              //                                     Text(
                              //                                       'Associates',
                              //                                       style: Theme.of(context)
                              //                                           .textTheme
                              //                                           .bodyText1!
                              //                                           .copyWith(
                              //                                             fontFamily: 'Poppins',
                              //                                             color: Colors.green,
                              //                                           ),
                              //                                     ),
                              //                                   ],
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //             // Padding(
                              //             //   padding: EdgeInsetsDirectional
                              //             //       .fromSTEB(15, 5, 10, 0),
                              //             //   child: Row(
                              //             //     mainAxisSize:
                              //             //     MainAxisSize.max,
                              //             //     children: [
                              //             //       Icon(
                              //             //         Icons.monetization_on_rounded,
                              //             //         // color: Colors.black,
                              //             //         size: 15,
                              //             //       ),
                              //             //       Expanded(
                              //             //         child: Padding(
                              //             //           padding:
                              //             //           EdgeInsetsDirectional
                              //             //               .fromSTEB(10, 0,
                              //             //               0, 0),
                              //             //           child: Text(
                              //             //             '8853627910',
                              //             //             style:
                              //             //             Theme.of(context)
                              //             //                 .textTheme
                              //             //                 .bodyText1,
                              //             //           ),
                              //             //         ),
                              //             //       ),
                              //             //     ],
                              //             //   ),
                              //             // ),
                              //             Row(
                              //               mainAxisSize: MainAxisSize.max,
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment
                              //                       .spaceAround,
                              //               children: [
                              //                 Expanded(
                              //                   child: Align(
                              //                     alignment:
                              //                         const AlignmentDirectional(
                              //                             -0.15, 0),
                              //                     child: Padding(
                              //                       padding:
                              //                           const EdgeInsetsDirectional
                              //                               .fromSTEB(0, 10,
                              //                                   0, 0),
                              //                       child: ClipRRect(
                              //                         borderRadius:
                              //                             const BorderRadius.only(
                              //                                 bottomLeft: Radius
                              //                                     .circular(
                              //                                         10),
                              //                                 bottomRight: Radius
                              //                                     .circular(
                              //                                         10)),
                              //                         child:
                              //                             LinearProgressIndicator(
                              //                           value:
                              //                               (paidPaymentHisCardItem *
                              //                                       1509.08) /
                              //                                   16607,
                              //                           // width: 200,
                              //                           // lineHeight: 20,
                              //                           // animation: true,
                              //                           // valueColor:
                              //                           // Theme.of(context).textTheme.headline6!.color,                                                            .primaryColor,
                              //                           backgroundColor:
                              //                               const Color(
                              //                                   0xFFF1F4F8),
                              //                           // center: Text(
                              //                           //   '10%',
                              //                           //   textAlign:
                              //                           //   TextAlign.start,
                              //                           //   style: Theme.of(context).textTheme
                              //                           //       .bodyText1
                              //                           //       !.copyWith(
                              //                           //     fontFamily:
                              //                           //     'Poppins',
                              //                           //     color: Theme.of(context).backgroundColor,
                              //                           //   ),
                              //                           // ),
                              //                           // radius:
                              //                           // Radius.circular(
                              //                           //     10),
                              //                           // padding:
                              //                           // EdgeInsets.zero,
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class TypeBottomSheet extends StatefulWidget {
  const TypeBottomSheet({Key? key}) : super(key: key);

  @override
  State<TypeBottomSheet> createState() => _TypeBottomSheetState();
}

class _TypeBottomSheetState extends State<TypeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      enableDrag: false,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: Get.height * 0.6,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            // color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  h6Text('Choose a type'),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: h6Text('Clear Filter', color: Colors.blue))
                ],
              ),
              const Divider(),
              Expanded(
                  child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  ...['Associates', 'Customer'].map((e) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Get.back();
                          },
                          title: b1Text(e),
                        ),
                        const Divider(),
                      ],
                    );
                  }),
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}

class MIDateFilterSheet extends StatefulWidget {
  const MIDateFilterSheet({Key? key, required this.type}) : super(key: key);
  final IncomeType type;

  @override
  State<MIDateFilterSheet> createState() => _MIDateFilterSheetState();
}

class _MIDateFilterSheetState extends State<MIDateFilterSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyIncomeProvider>(builder: (context, mip, _) {
      return BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          const Icon(Icons.clear),
                          const SizedBox(width: 10),
                          h6Text('Select Dates'),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          mip.filterData = {};
                          mip.filterApplied = false;
                          setState(() {});
                          widget.type == IncomeType.direct
                              ? await mip
                                  .getDirIncomes()
                                  .then((value) => Get.back())
                              : widget.type == IncomeType.referral
                                  ? await mip
                                      .getRefIncomes()
                                      .then((value) => Get.back())
                                  : await mip
                                      .getGifts(true)
                                      .then((value) => Get.back());
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.clear,
                          // color: Colors.blue,
                        ),
                        label: const Text(
                          'Clear',
                          // color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            h6Text(
                                DateFormat('dd MMM yyyy').format(mip.fromDate)),
                            IconButton(
                                onPressed: () {
                                  mip.searchWidget(
                                      field: 'fd', context: context);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  Theme.of(context).textTheme.caption!.color),
                          height: 5,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            h6Text(
                                DateFormat('dd MMM yyyy').format(mip.toDate)),
                            IconButton(
                                onPressed: () {
                                  mip.searchWidget(
                                      field: 'td', context: context);
                                },
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  Theme.of(context).textTheme.caption!.color),
                          height: 5,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              mip.filterApplied = true;
                              mip.filterData.addAll({
                                'from_date':
                                    mip.fromDate.toString().split(' ').first,
                                'to_date':
                                    mip.toDate.toString().split(' ').first,
                                "keyword": ""
                              });
                              widget.type == IncomeType.direct
                                  ? await mip
                                      .getDirIncomes()
                                      .then((value) => Get.back())
                                  : widget.type == IncomeType.referral
                                      ? await mip.getRefIncomes().then((value) {
                                          Get.back();
                                          mip.selectedType = null;
                                          mip.selectedMember = null;
                                        })
                                      : await mip
                                          .getGifts(true)
                                          .then((value) => Get.back());
                              setState(() {});
                            },
                            child: const Text('Apply')),
                      ),
                    ],
                  )
                ],
              ),
            );
          });
    });
  }
}
