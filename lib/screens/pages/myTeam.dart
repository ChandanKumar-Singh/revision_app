import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revision/providers/teamCcontroller.dart';

class UserslistWidget extends StatefulWidget {
  const UserslistWidget({Key? key}) : super(key: key);

  @override
  _UserslistWidgetState createState() => _UserslistWidgetState();
}

class _UserslistWidgetState extends State<UserslistWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void init() async {
    await Provider.of<TeamProvider>(context, listen: false).getTeam();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<bool> willPop() async {
    var tp = Provider.of<TeamProvider>(context, listen: false);
    tp.members.clear();
    tp.total = 0;
    tp.loadingMembers = false;
    debugPrint('On will pop Members length ${tp.members.length} ');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Consumer<TeamProvider>(builder: (context, tp, _) {
        return Scaffold(
          key: scaffoldKey,
          // backgroundColor: Color(0xFFF1F4F8),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 30,
              ),
              onPressed: () async {
                Get.back();
              },
            ),
            title: const Text(
              'My  Team',
              style: TextStyle(
                fontFamily: 'Lexend Deca',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: const [],
            centerTitle: true,
            elevation: 2,
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   children: const [
                //     Expanded(
                //       child: Padding(
                //         padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
                //         child: Text(
                //           '12-10-2022',
                //           style: TextStyle(
                //             fontFamily: 'Lexend Deca',
                //             fontSize: 14,
                //             // color: Get.theme.cardColor,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: tp.members.length,
                      itemBuilder: (context, i) {
                        var member = tp.members[i];

                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16, i == 0 ? 20 : 5, 16, 8),
                          child: Container(
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
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      12, 4, 12, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 0),
                                        child: Text(
                                          '${member.designationId ?? ' '}',
                                          style: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            fontSize: 14,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        member.createdAt != null
                                            ? DateFormat('dd MMM yyyy')
                                            .format(DateTime.parse(
                                            member.createdAt!))
                                            : '',
                                        style: Get.textTheme.bodyText1,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.85,
                                  height: 1,
                                  decoration: const BoxDecoration(),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      12, 4, 12, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 0),
                                        child: Text(
                                          member.fullName ?? '',
                                          style: Get.textTheme.subtitle1!
                                              .copyWith(
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
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      12, 4, 12, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 4),
                                              child: Icon(
                                                Icons.call,
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Text(
                                                member.phone ?? 'N/A',
                                                style: Get
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                  fontFamily: 'Lexend Deca',
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
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 4),
                                              child: Icon(
                                                Icons
                                                    .local_activity_outlined,
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Text(
                                                member.status ?? '',
                                                style: Get
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                  fontFamily: 'Lexend Deca',
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
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 12, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 4),
                                              child: Icon(
                                                Icons.local_atm_sharp,
                                                size: 20,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Text(
                                                member.email ?? 'N/A',
                                                style: Get
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                  fontFamily: 'Lexend Deca',
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
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      12, 4, 12, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Plot Amount :',
                                        style: Get.textTheme.bodyText1,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
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
                                                    style: Get.textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Get.theme
                                                          .primaryColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      4, 0, 0, 0),
                                                  child: Text(
                                                    member.plotTotalPrice ??
                                                        '',
                                                    style: Get.textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Get.theme
                                                          .primaryColor,
                                                      fontSize: 14,
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
                                  const EdgeInsetsDirectional.fromSTEB(
                                      12, 4, 12, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Tot Paid :',
                                        style: Get.textTheme.bodyText1,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
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
                                                    style: Get.textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Get.theme
                                                          .primaryColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      4, 0, 0, 0),
                                                  child: Text(
                                                    member.plotRate ?? '',
                                                    style: Get.textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Get.theme
                                                          .primaryColor,
                                                      fontSize: 14,
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
                                  const EdgeInsetsDirectional.fromSTEB(
                                      12, 4, 12, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Due :',
                                        style: Get.textTheme.bodyText1,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
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
                                                    style: Get.textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Get.textTheme
                                                          .bodyText1!.color,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      4, 0, 0, 0),
                                                  child: Text(
                                                    member.plotRate ?? '',
                                                    style: Get.textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Get.textTheme
                                                          .bodyText1!.color,
                                                      fontSize: 14,
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
                          ),
                        );
                      },
                    )
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
