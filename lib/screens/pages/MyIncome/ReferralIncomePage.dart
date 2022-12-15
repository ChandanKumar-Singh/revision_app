import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/functions.dart';
import 'package:revision/models/referalIncomeMOdel.dart';
import 'package:revision/providers/myIncomeProvider.dart';

import '../../../models/TeamMemberModel.dart';
import '../../../providers/teamCcontroller.dart';
import 'directIncome.dart';

class ReferralIncomePage extends StatefulWidget {
  const ReferralIncomePage({Key? key}) : super(key: key);

  @override
  _ReferralIncomePageState createState() => _ReferralIncomePageState();
}

class _ReferralIncomePageState extends State<ReferralIncomePage> {
  String? choiceChipsValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void init() async {

    var mip = Provider.of<MyIncomeProvider>(context, listen: false);
    mip.refIncomes.clear();
    mip.newRefIncomes.clear();
    mip.totalRefIncomes = 0;
    mip.loadingRefIncomes = false;
    mip.filterApplied = false;
    mip.filterData.clear();
    mip.selectedMember = null;
    mip.selectedType = null;

    mip.fromDate = DateTime.now().subtract(const Duration(days: 1));
    mip.toDate = DateTime.now();
    debugPrint('On will pop withdraws length ${mip.refIncomes.length} ');
    await mip.getRefIncomes();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

    Provider.of<MyIncomeProvider>(context, listen: false).rfScontroller =
        ScrollController()
          ..addListener(
              Provider.of<MyIncomeProvider>(context, listen: false).rfLoadMore);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Provider.of<MyIncomeProvider>(context, listen: false)
        .rfScontroller
        .removeListener(
            Provider.of<MyIncomeProvider>(context, listen: false).rfLoadMore);
    super.dispose();
  }

  Future<bool> willPop() async {
    var mip = Provider.of<MyIncomeProvider>(context, listen: false);
    mip.refIncomes.clear();
    mip.newRefIncomes.clear();
    mip.totalRefIncomes = 0;
    mip.loadingRefIncomes = false;
    mip.filterApplied = false;
    mip.filterData.clear();
    mip.selectedMember = null;
    mip.selectedType = null;

    mip.fromDate = DateTime.now().subtract(const Duration(days: 1));
    mip.toDate = DateTime.now();
    debugPrint('On will pop withdraws length ${mip.refIncomes.length} ');
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
                        'Referral Income',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       showModalBottomSheet(
                      //           context: context,
                      //           builder: (context) {
                      //             return const MIDateFilterSheet(
                      //               type: IncomeType.referral,
                      //             );
                      //           });
                      //     },
                      //     icon: Stack(
                      //       children: [
                      //         const Icon(Icons.filter_list),
                      //         if (mip.filterApplied)
                      //           Positioned(
                      //             right: 0,
                      //             child: Container(
                      //               decoration: const BoxDecoration(
                      //                 color: Colors.red,
                      //                 shape: BoxShape.circle,
                      //               ),
                      //               height: 7,
                      //               width: 7,
                      //             ),
                      //           ),
                      //       ],
                      //     )),
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
                      Container(),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    // height: 50,
                    padding: const EdgeInsets.only(left: 20),
                    decoration: const BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    child: Builder(
                      builder: (context) {
                        return Wrap(
                          // direction: Axis.horizontal,
                          children: [
                            Chip(
                              onDeleted: () {
                                openCustomBottomSheet(
                                    const TeamMembersBottomSheet());
                              },
                              deleteIcon: Icon(
                                Icons.arrow_drop_down,
                                color: mip.selectedMember != null
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .color,
                              ),
                              backgroundColor: mip.selectedMember != null
                                  ? Colors.teal
                                  : Theme.of(context).chipTheme.backgroundColor,
                              label: Text(
                                mip.selectedMember != null
                                    ? mip.selectedMember!.fullName!
                                    : 'Select Member',
                                style: TextStyle(
                                  color: mip.selectedMember != null
                                      ? Colors.white
                                      : Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color,
                                ),
                              ),

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
                              deleteIcon: Icon(
                                Icons.arrow_drop_down,
                                color: mip.selectedType != null
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .color,
                              ),
                              backgroundColor: mip.selectedType != null
                                  ? Colors.purple
                                  : Theme.of(context).chipTheme.backgroundColor,
                              label: Text(
                                mip.selectedType != null
                                    ? (mip.selectedType == 1
                                        ? UserType.customer.name.capitalize!
                                        : UserType.associate.name.capitalize!)
                                    : 'Select Type',
                                style: TextStyle(
                                  color: mip.selectedType != null
                                      ? Colors.white
                                      : Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .color,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Chip(
                              onDeleted: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return const MIDateFilterSheet(
                                        type: IncomeType.referral,
                                      );
                                    });
                              },
                              deleteIcon: Icon(
                                Icons.arrow_drop_down,
                                color: mip.filterApplied
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .color,
                              ),
                              backgroundColor: mip.filterApplied
                                  ? Colors.deepPurpleAccent
                                  : Theme.of(context).chipTheme.backgroundColor,
                              label: mip.filterApplied
                                  ? RichText(
                                      text: TextSpan(
                                          text:
                                              '${DateFormat('dd MMM yyyy').format(mip.fromDate)}',
                                          style: TextStyle(
                                            color: mip.filterApplied
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .color,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '  To  ',
                                              style: TextStyle(
                                                color: mip.filterApplied
                                                    ? Colors.yellow
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .color,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '${DateFormat('dd MMM yyyy').format(mip.toDate)}',
                                              style: TextStyle(
                                                color: mip.filterApplied
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .color,
                                              ),
                                            ),
                                          ]),
                                    )
                                  : const Text('Select Dates'),
                            ),
                            // const SizedBox(width: 10),
                            // SizedBox(
                            //   width: Get.width / 3,
                            //   child: Row(
                            //     children: [
                            //
                            //       Expanded(
                            //         child: Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               vertical: 8.0),
                            //           child: TextField(
                            //             decoration: InputDecoration(
                            //                 contentPadding:
                            //                     const EdgeInsets.symmetric(
                            //                         horizontal: 10,
                            //                         vertical: 5),
                            //                 hintStyle:
                            //                     const TextStyle(fontSize: 10),
                            //                 suffixIcon: FittedBox(
                            //                   child: IconButton(
                            //                     icon: const Icon(
                            //                       Icons.search,
                            //                     ),
                            //                     onPressed: () {},
                            //                   ),
                            //                 )),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: Builder(builder: (context) {
                        return Column(
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
                                            oCcy.format(mip.totalRefIncomes),
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
                                    controller: mip.rfScontroller,
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 10),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: mip.newRefIncomes.length,
                                    itemBuilder: (context, i) {
                                      var income = mip.newRefIncomes[i];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, i == 0 ? 20 : 5, 0, 16),
                                        child: buildReferralIncomeCard(
                                            income, context),
                                      );
                                    },
                                  ),
                                  if (mip.isRfLoadMoreRunning)
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
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildReferralIncomeCard(
      ReferralIncomeModel income, BuildContext context) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          // boxShadow: const [
          //   BoxShadow(
          //     blurRadius: 3,
          //     offset: Offset(0, 1),
          //   )
          // ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      income.directIncomes!.user!.designationId == 1
                          ? 'Customer'
                          : "Associate",
                      style: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        income.createdAt != null
                            ? DateFormat('dd MMM yyyy')
                                .format(DateTime.parse(income.fromDate!))
                            : '',
                        style: Get.textTheme.bodyText1,
                      ),
                      const SizedBox(width: 5),
                      const Text('-'),
                      const SizedBox(width: 5),
                      Text(
                        income.createdAt != null
                            ? DateFormat('dd MMM yyyy')
                                .format(DateTime.parse(income.toDate!))
                            : '',
                        style: Get.textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 1,
              decoration: const BoxDecoration(),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      income.directIncomes!.user!.fullName ?? '',
                      style: Get.textTheme.subtitle1!.copyWith(
                        fontFamily: 'Lexend Deca',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Icon(
                            Icons.call,
                            size: 20,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(
                            income.directIncomes!.user!.phone ?? 'N/A',
                            style: Get.textTheme.bodyText1!.copyWith(
                              fontFamily: 'Lexend Deca',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: FaIcon(
                            FontAwesomeIcons.award,
                            size: 20,
                            color: Colors.amber,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(
                            ' Level  ${income.level ?? ''}',
                            style: Get.textTheme.bodyText1!.copyWith(
                              fontFamily: 'Lexend Deca',
                              fontWeight: FontWeight.w500,
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
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                          child: Icon(
                            Icons.email_outlined,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(
                            income.directIncomes!.user!.email ?? 'N/A',
                            style: Get.textTheme.bodyText1!.copyWith(
                              fontFamily: 'Lexend Deca',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
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
              padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Total Sale :',
                    style: Get.textTheme.bodyText1,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4, 0, 0, 0),
                              child: Text(
                                '₹',
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontFamily: 'Lexend Deca',
                                  color: Get.textTheme.bodyText1!.color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4, 0, 0, 0),
                              child: Text(
                                oCcy.format(
                                    double.parse(income.totalSale ?? '0')),
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontFamily: 'Lexend Deca',
                                  color: Get.textTheme.bodyText1!.color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
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
              padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Total Recieved :',
                    style: Get.textTheme.bodyText1,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4, 0, 0, 0),
                              child: Text(
                                '₹',
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontFamily: 'Lexend Deca',
                                  color: Get.textTheme.bodyText1!.color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4, 0, 0, 0),
                              child: Text(
                                oCcy.format(
                                    double.parse(income.totalRecieved ?? '0')),
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontFamily: 'Lexend Deca',
                                  color: Get.textTheme.bodyText1!.color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
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
              padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Referral Income :',
                    style: Get.textTheme.bodyText1,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4, 0, 0, 0),
                              child: Text(
                                '₹',
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontFamily: 'Lexend Deca',
                                  color: Get.textTheme.bodyText1!.color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4, 0, 0, 0),
                              child: Text(
                                oCcy.format(
                                    double.parse(income.referralIncome ?? '0')),
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontFamily: 'Lexend Deca',
                                  color: Get.textTheme.bodyText1!.color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
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
    return Consumer<MyIncomeProvider>(builder: (context, mip, _) {
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
                    Expanded(
                      child: h6Text('Choose a team member'),
                    ),
                    TextButton(
                        onPressed: () {
                          mip.setSelectedMember(null);
                          Get.back();
                        },
                        child: h6Text('Clear Filter', color: Colors.blue))
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
                    ...mip.refMembers.map((e) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              mip.setSelectedMember(e);
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
                            title: b1Text(
                              e.fullName ?? '',
                              fontWeight: FontWeight.bold,
                            ),
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
    });
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
        return Consumer<MyIncomeProvider>(builder: (context, mip, _) {
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
                        onPressed: () {
                          mip.setSelectedType(null);
                          Get.back();
                        },
                        child: h6Text('Clear Filter', color: Colors.blue))
                  ],
                ),
                const Divider(),
                Expanded(
                    child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    ...UserType.values.map((e) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              mip.setSelectedType(
                                  e == UserType.customer ? 1 : 2);
                              Get.back();
                            },
                            title: h6Text(e.name.capitalize!,
                                fontWeight: FontWeight.normal),
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
        });
      },
    );
  }
}
