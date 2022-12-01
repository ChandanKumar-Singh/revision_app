import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/functions.dart';

class DirectIncome extends StatefulWidget {
  const DirectIncome({Key? key}) : super(key: key);

  @override
  _DirectIncomeState createState() => _DirectIncomeState();
}

class _DirectIncomeState extends State<DirectIncome> {
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
                    'Direct Income',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Container(),
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
              Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0x00FFFFFF),
                ),
                child: Builder(
                  builder: (context) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: 10),
                        Chip(
                          onDeleted: () {
                            openCustomBottomSheet(
                                const TeamMembersBottomSheet());
                          },
                          deleteIcon: const Icon(Icons.arrow_drop_down),
                          label: const Text('Select Member'),

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
                        const SizedBox(width: 10),
                        Chip(
                          onDeleted: () {
                            openCustomBottomSheet(const TypeBottomSheet());
                          },
                          deleteIcon: const Icon(Icons.arrow_drop_down),
                          label: const Text('Select Type'),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: Get.width / 3,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                        hintStyle:
                                            const TextStyle(fontSize: 10),
                                        suffixIcon: FittedBox(
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.search,
                                            ),
                                            onPressed: () {},
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Builder(
                              builder: (context) {
                                final paidPaymentHisCard =
                                    List.generate(11, (index) => index)
                                        .toList()
                                        .take(10)
                                        .toList();
                                return ListView.builder(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 10),
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: paidPaymentHisCard.length,
                                  itemBuilder: (context, previousIndex) {
                                    final previousItem =
                                        paidPaymentHisCard[previousIndex];
                                    return Container(
                                      margin:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 5, 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Get.theme.cardColor,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 3,
                                            offset: Offset(0, 1),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12, 4, 12, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 0),
                                                  child: Text(
                                                    'Assocaite',
                                                    style: TextStyle(
                                                      fontFamily: 'Lexend Deca',
                                                      fontSize: 14,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '12-10-2022',
                                                  style:
                                                      Get.textTheme.bodyText1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            height: 1,
                                            decoration: const BoxDecoration(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12, 4, 12, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 4, 0, 0),
                                                  child: Text(
                                                    'Rajesh Pandey (100040)',
                                                    style: Get
                                                        .textTheme.subtitle1!
                                                        .copyWith(
                                                      fontFamily: 'Lexend Deca',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12, 4, 12, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 4),
                                                        child: Icon(
                                                          Icons.call,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                4, 0, 0, 0),
                                                        child: Text(
                                                          '9135324545',
                                                          style: Get.textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 4),
                                                        child: Icon(
                                                          Icons
                                                              .local_activity_outlined,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                4, 0, 0, 0),
                                                        child: Text(
                                                          'Active',
                                                          style: Get.textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12, 0, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 4),
                                                        child: Icon(
                                                          Icons.local_atm_sharp,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                4, 0, 0, 0),
                                                        child: Text(
                                                          'chandankusingh4545@gmail.com',
                                                          style: Get.textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                            fontFamily:
                                                                'Lexend Deca',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12, 4, 12, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Plot Amount :',
                                                  style:
                                                      Get.textTheme.bodyText1,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    4, 0, 0, 0),
                                                            child: Text(
                                                              'Rs.',
                                                              style: Get
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Get.theme
                                                                    .primaryColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    4, 0, 0, 0),
                                                            child: Text(
                                                              '1750000000.0',
                                                              style: Get
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Get.theme
                                                                    .primaryColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12, 4, 12, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Tot Paid :',
                                                  style:
                                                      Get.textTheme.bodyText1,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    4, 0, 0, 0),
                                                            child: Text(
                                                              'Rs.',
                                                              style: Get
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Get.theme
                                                                    .primaryColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    4, 0, 0, 0),
                                                            child: Text(
                                                              '1750000000.0',
                                                              style: Get
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Get.theme
                                                                    .primaryColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(12, 4, 12, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Due :',
                                                  style:
                                                      Get.textTheme.bodyText1,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    4, 0, 0, 0),
                                                            child: Text(
                                                              'Rs.',
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
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    4, 0, 0, 0),
                                                            child: Text(
                                                              '0.0',
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
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                    );
                                  },
                                );
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
                              },
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

void openCustomBottomSheet(Widget child) {
  showCupertinoModalPopup(
    context: Get.context!,
    builder: (context) {
      return child;
    },
  );
}

class TeamMembersBottomSheet extends StatefulWidget {
  const TeamMembersBottomSheet({Key? key}) : super(key: key);

  @override
  State<TeamMembersBottomSheet> createState() => _TeamMembersBottomSheetState();
}

class _TeamMembersBottomSheetState extends State<TeamMembersBottomSheet> {
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
                  Expanded(child: h6Text('Choose a team member')),
                 TextButton(onPressed: (){},child: h6Text('Clear Filter',color: Colors.blue))
                ],
              ),
              const Divider(),
              Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search here',
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  ...[
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    9,
                  ].map((e) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Get.back();
                          },
                          leading: Container(
                            width: 30,
                            height: 30,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: !isOnline
                                ? Image.network(
                                    'https://picsum.photos/seed/901/600',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('assets/user.png'),
                          ),
                          title: b1Text('Chandan Kumar Singh'),
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
                  Spacer(),
                  TextButton(onPressed: (){},child: h6Text('Clear Filter',color: Colors.blue))

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
