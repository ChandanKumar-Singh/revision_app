import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revision/functions.dart';

class MyPaidPaymentsWidget extends StatefulWidget {
  const MyPaidPaymentsWidget({Key? key}) : super(key: key);

  @override
  _MyPaidPaymentsWidgetState createState() => _MyPaidPaymentsWidgetState();
}

class _MyPaidPaymentsWidgetState extends State<MyPaidPaymentsWidget> {
  String? choiceChipsValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: Theme.of(context).textTheme.primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
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
                    'My Paid Payments',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  IconButton(
                    // borderColor: Colors.transparent,
                    // borderRadius: 30,
                    // borderWidth: 1,
                    // buttonSize: 60,
                    icon: Icon(
                      Icons.search_rounded,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      size: 30,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0x00FFFFFF),
                ),
                child: Builder(
                  builder: (context) {
                    final filterChips = List.generate(10, (index) => index)
                        .toList()
                        .take(5)
                        .toList();
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: filterChips.length,
                      itemBuilder: (context, filterChipsIndex) {
                        final filterChipsItem = filterChips[filterChipsIndex];
                        return Container(
                          decoration: const BoxDecoration(),
                          child: const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Chip(
                              label: Text('Options'),
                              // options: [
                              //   ChipData('Option 1', Icons.train_outlined)
                              // ],
                              // onChanged: (val) =>
                              //     setState(() => choiceChipsValue = val?.first),
                              // selectedChipStyle: ChipStyle(
                              //   backgroundColor: Color(0xFF323B45),
                              //   textStyle: Theme.of(context).textTheme
                              //       .bodyText1
                              //       !.copyWith(
                              //     fontFamily: 'Poppins',
                              //     color: Colors.white,
                              //   ),
                              //   iconColor: Colors.white,
                              //   iconSize: 18,
                              //   elevation: 4,
                              // ),
                              // unselectedChipStyle: ChipStyle(
                              //   backgroundColor: Colors.white,
                              //   textStyle: Theme.of(context).textTheme
                              //       .bodyText2
                              //       !.copyWith(
                              //     fontFamily: 'Poppins',
                              //     color: Color(0xFF323B45),
                              //   ),
                              //   iconColor: Color(0xFF323B45),
                              //   iconSize: 18,
                              //   elevation: 4,
                              // ),
                              // chipSpacing: 20,
                              // multiselect: false,
                              // alignment: WrapAlignment.start,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
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
                                    const Icon(Icons.currency_rupee_rounded),
                                    Text(
                                      '${1509.80 * 11}',
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
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 10, 0, 10),
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Builder(
                                builder: (context) {
                                  final paidPaymentHisCard =
                                      List.generate(11, (index) => index)
                                          .toList()
                                          .take(10)
                                          .toList();
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: paidPaymentHisCard.length,
                                    itemBuilder:
                                        (context, paidPaymentHisCardIndex) {
                                      final paidPaymentHisCardItem =
                                          paidPaymentHisCard[
                                              paidPaymentHisCardIndex];
                                      return Container(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 1, 0),
                                        margin: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 1, 10),
                                        width: double.infinity,
                                        // height: 100,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(1, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 10, 0),
                                                    child: Text(
                                                      '26-11-2022',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Row(
                                              //   mainAxisSize: MainAxisSize.max,
                                              //   children: [
                                              //     Padding(
                                              //       padding:
                                              //           const EdgeInsetsDirectional
                                              //                   .fromSTEB(
                                              //               10, 0, 0, 0),
                                              //       child: Container(
                                              //         width: 30,
                                              //         height: 30,
                                              //         clipBehavior:
                                              //             Clip.antiAlias,
                                              //         decoration: BoxDecoration(
                                              //           shape: BoxShape.circle,
                                              //         ),
                                              //         child: !isOnline
                                              //             ? Image.network(
                                              //                 'https://picsum.photos/seed/901/600',
                                              //                 fit: BoxFit.cover,
                                              //               )
                                              //             : Image.asset(
                                              //                 'assets/user.png'),
                                              //       ),
                                              //     ),
                                              //     Expanded(
                                              //       child: Padding(
                                              //         padding:
                                              //             const EdgeInsetsDirectional
                                              //                     .fromSTEB(
                                              //                 10, 0, 0, 0),
                                              //         child: Row(
                                              //           mainAxisSize:
                                              //               MainAxisSize.max,
                                              //           children: [
                                              //             Expanded(
                                              //               child: Column(
                                              //                 mainAxisSize:
                                              //                     MainAxisSize
                                              //                         .max,
                                              //                 crossAxisAlignment:
                                              //                     CrossAxisAlignment
                                              //                         .start,
                                              //                 children: [
                                              //                   Text(
                                              //                     'Chandan Kumar Singh',
                                              //                     style: Theme.of(
                                              //                             context)
                                              //                         .textTheme
                                              //                         .bodyText1,
                                              //                   ),
                                              //                   Padding(
                                              //                     padding:
                                              //                         const EdgeInsetsDirectional
                                              //                                 .fromSTEB(
                                              //                             0,
                                              //                             0,
                                              //                             10,
                                              //                             0),
                                              //                     child: Row(
                                              //                       mainAxisSize:
                                              //                           MainAxisSize
                                              //                               .max,
                                              //                       mainAxisAlignment:
                                              //                           MainAxisAlignment
                                              //                               .spaceBetween,
                                              //                       children: [
                                              //                         Row(
                                              //                           children: [
                                              //                             Icon(
                                              //                               Icons.currency_rupee_rounded,
                                              //                               size:
                                              //                                   15,
                                              //                             ),
                                              //                             Text(
                                              //                               '${1509.80}',
                                              //                               style:
                                              //                                   Theme.of(context).textTheme.bodyText1,
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                         Text(
                                              //                           'Cash',
                                              //                           style: Theme.of(context)
                                              //                               .textTheme
                                              //                               .bodyText1!
                                              //                               .copyWith(
                                              //                                 fontFamily: 'Poppins',
                                              //                                 color: Colors.green,
                                              //                               ),
                                              //                         ),
                                              //                       ],
                                              //                     ),
                                              //                   ),
                                              //                 ],
                                              //               ),
                                              //             ),
                                              //           ],
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        10, 0, 10, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .currency_rupee_rounded,
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          '${1509.80}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'Cash',
                                                      style:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(15, 5, 10, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    const Icon(
                                                      Icons.comment,
                                                      // color: Colors.black,
                                                      size: 15,
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(10, 0,
                                                                    0, 0),
                                                        child: Text(
                                                          'PhonePe #8853627910',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              -0.15, 0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(0, 10,
                                                                    0, 0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                          child:
                                                              LinearProgressIndicator(
                                                            value:
                                                                (paidPaymentHisCardItem *
                                                                        1509.08) /
                                                                    16607,
                                                            // width: 200,
                                                            // lineHeight: 20,
                                                            // animation: true,
                                                            // valueColor:
                                                            // Theme.of(context).textTheme.headline6!.color,                                                            .primaryColor,
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFF1F4F8),
                                                            // center: Text(
                                                            //   '10%',
                                                            //   textAlign:
                                                            //   TextAlign.start,
                                                            //   style: Theme.of(context).textTheme
                                                            //       .bodyText1
                                                            //       !.copyWith(
                                                            //     fontFamily:
                                                            //     'Poppins',
                                                            //     color: Theme.of(context).backgroundColor,
                                                            //   ),
                                                            // ),
                                                            // radius:
                                                            // Radius.circular(
                                                            //     10),
                                                            // padding:
                                                            // EdgeInsets.zero,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
