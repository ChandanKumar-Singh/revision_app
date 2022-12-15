import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/functions.dart';
import 'package:revision/providers/paidPaymentsProvider.dart';

class MyPaidPaymentsPage extends StatefulWidget {
  const MyPaidPaymentsPage({Key? key}) : super(key: key);

  @override
  _MyPaidPaymentsPageState createState() => _MyPaidPaymentsPageState();
}

class _MyPaidPaymentsPageState extends State<MyPaidPaymentsPage> {
  String? choiceChipsValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void init() async {
    await Provider.of<PaidPaymentsProvider>(context, listen: false)
        .getPaimentHistory(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<bool> willPop() async {
    var tp = Provider.of<PaidPaymentsProvider>(context, listen: false);
    // tp.payments.clear();
    tp.total = 0;
    tp.loadingMembers = false;
    debugPrint('On will pop Members length ${tp.payments.length} ');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Consumer<PaidPaymentsProvider>(builder: (context, ppp, _) {
        return Scaffold(
          key: scaffoldKey,
          // backgroundColor: Theme.of(context).cardColor.withOpacity(0.8),
          appBar: AppBar(
            title: const Text(
              'My Paid Payments',
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(builder: (context) {
                          return SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 15,
                                  child: Container(
                                    width: Get.width / 3.5,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(
                                      //   color: Theme.of(context)
                                      //       .textTheme
                                      //       .headline6!
                                      //       .color!,
                                      // ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        b1Text(
                                          oCcy.format(
                                              double.parse(ppp.totalAmount)),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: b1Text(
                                                'Total',
                                                maxLine: 1,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            b1Text(' (In ₹)',
                                                color: Colors.white),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 15,
                                  child: Container(
                                    width: Get.width / 3.5,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(
                                      //   color: Theme.of(context)
                                      //       .textTheme
                                      //       .headline6!
                                      //       .color!,
                                      // ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        b1Text(
                                          oCcy.format(
                                              double.parse(ppp.totalPaid)),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: b1Text(
                                                'Deposited',
                                                maxLine: 1,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            b1Text(' (In ₹)',
                                                color: Colors.white),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 15,
                                  child: Container(
                                    width: Get.width / 3.5,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(
                                      //   color: Theme.of(context)
                                      //       .textTheme
                                      //       .headline6!
                                      //       .color!,
                                      // ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        b1Text(
                                          oCcy.format(
                                              double.parse(ppp.toBePaid)),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: b1Text(
                                                'Dues',
                                                maxLine: 1,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            b1Text(
                                              ' (In ₹)',
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: ppp.payments.length,
                              itemBuilder: (context, i) {
                                final payments = ppp.payments[i];

                                return Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 1, 10),
                                  child: Container(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            2, 10, 2, 0),
                                    // margin: const EdgeInsetsDirectional.fromSTEB(
                                    //     0, 0, 1, 10),
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
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
                                                        .fromSTEB(0, 0, 10, 0),
                                                child: Text(
                                                  payments.date ?? '',
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 10, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
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
                                                      oCcy.format(
                                                        double.parse(payments.amount ?? '0')),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  payments.paymentMode ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.green,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(15, 5, 10, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
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
                                                                .fromSTEB(
                                                            10, 0, 0, 0),
                                                    child: Text(
                                                      payments.comments ?? '',
                                                      style: Theme.of(context)
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -0.15, 0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 10, 0, 0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                      child:
                                                          LinearProgressIndicator(
                                                        value: (double.parse(
                                                                payments.amount ??
                                                                    '0')) /
                                                            double.parse(
                                                                ppp.totalPaid),
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
                                  ),
                                );
                              },
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
        );
      }),
    );
  }
}
