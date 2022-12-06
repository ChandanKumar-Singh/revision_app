import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/widgets.dart';

import '../../../providers/PaymentsHistoryProvider.dart';

class ReceivedPaymentsPage extends StatefulWidget {
  const ReceivedPaymentsPage({Key? key}) : super(key: key);

  @override
  _ReceivedPaymentsPageState createState() => _ReceivedPaymentsPageState();
}

class _ReceivedPaymentsPageState extends State<ReceivedPaymentsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void init() async {
    await Provider.of<PaymentsHistoryProvider>(context, listen: false)
        .getReceived();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<bool> willPop() async {
    var php = Provider.of<PaymentsHistoryProvider>(context, listen: false);
    php.receives.clear();
    php.totalReceived = 0;
    php.filterApplied = false;
    php.filterData.clear();
    php.fromDate = DateTime.now().subtract(const Duration(days: 1));
    php.toDate = DateTime.now();
    debugPrint('On will pop withdraws length ${php.receives.length} ');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Consumer<PaymentsHistoryProvider>(builder: (context, php, _) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).cardColor.withOpacity(0.9),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  Theme.of(context).colorScheme.onBackground.withOpacity(1),
                ],
                stops: const [0, 1],
                begin: const AlignmentDirectional(0, -1),
                end: const AlignmentDirectional(0, 1),
              ),
            ),
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverAppBar(
                  expandedHeight: 220,
                  // collapsedHeight: 100,
                  pinned: true,
                  floating: true,
                  snap: false,
                  backgroundColor: Theme.of(context).primaryColor,
                  automaticallyImplyLeading: true,
                  // iconTheme:
                  // IconThemeData(color: Theme.of(context).colorScheme.primary),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const DateFilterSheet(
                                    type: HistoryType.received,
                                  );
                                });
                          },
                          icon: Stack(
                            children: [
                              const Icon(Icons.filter_list),
                              if (php.filterApplied)
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
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/precieved.jpg',
                      // 'assets/gift/gift-13.gif',
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    centerTitle: true,
                    expandedTitleScale: 1.2,
                    title: Text('Received Payments'),
                    // titlePadding:
                    //     const EdgeInsetsDirectional.fromSTEB(50, 10, 10, 10),
                    // title: SizedBox(
                    //   height: 30,
                    //   child: ListView(
                    //     padding: EdgeInsets.zero,
                    //     scrollDirection: Axis.horizontal,
                    //     // spacing: 10,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 15),
                    //         child: Chip(
                    //           deleteIcon: const Icon(Icons.arrow_drop_down),
                    //           onDeleted: () {
                    //             php.searchWidget(
                    //                 list: php.receives,
                    //                 field: 'fd',
                    //                 context: context);
                    //           },
                    //           label: Text(php.fromDate != null
                    //               ? DateFormat('dd MMM yyyy')
                    //                   .format(php.fromDate)
                    //               : 'From '),
                    //           backgroundColor: Theme.of(context).cardColor,
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 15),
                    //         child: Chip(
                    //           deleteIcon: const Icon(Icons.arrow_drop_down),
                    //           onDeleted: () {
                    //             php.searchWidget(
                    //                 list: php.receives,
                    //                 field: 'td',
                    //                 context: context);
                    //           },
                    //           label: Text(
                    //               DateFormat('dd MMM yyyy').format(php.toDate)),
                    //           backgroundColor: Theme.of(context).cardColor,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                  elevation: 0,
                )
              ],
              body: Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 5, 0),
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: php.receives.length,
                              itemBuilder: (context, i) {
                                final received = php.receives[i];

                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 5, 5),
                                  child: Container(
                                    width: double.infinity,
                                    // height: 100,
                                    decoration: BoxDecoration(
                                      color: const Color(0x00FFFFFF),
                                      borderRadius: BorderRadius.circular(10),
                                      shape: BoxShape.rectangle,
                                    ),

                                    /*
                                          ///design 1
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0, 30, 0, 0),
                                                child: Container(
                                                  width: double.infinity,
                                                  // height: 70,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).cardColor,
                                                    border: Border.all(),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                      topLeft: Radius.circular(0),
                                                      topRight: Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(10, 10, 10, 10),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize.max,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      'Requested for Rs. 30000',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline6,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .symmetric(
                                                                            horizontal:
                                                                                15,
                                                                            vertical:
                                                                                5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: const Color(
                                                                          0x9463F771),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  40),
                                                                      border:
                                                                          Border.all(
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Waiting',
                                                                          style: Theme.of(
                                                                                  context)
                                                                              .textTheme
                                                                              .bodyText1!
                                                                              .copyWith(
                                                                                fontFamily:
                                                                                    'Lato',
                                                                                color: Theme.of(context)
                                                                                    .colorScheme
                                                                                    .secondary,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize.max,
                                                                children: [
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional
                                                                                  .fromSTEB(
                                                                              0,
                                                                              5,
                                                                              0,
                                                                              0),
                                                                      child: Text(
                                                                        'description : Send me my next Payment',
                                                                        style: Theme.of(
                                                                                context)
                                                                            .textTheme
                                                                            .headline6,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize.max,
                                                                children: [
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional
                                                                                  .fromSTEB(
                                                                              0,
                                                                              5,
                                                                              0,
                                                                              0),
                                                                      child: Text(
                                                                        '# : i\'lll send you within 10 hours',
                                                                        style: Theme.of(
                                                                                context)
                                                                            .textTheme
                                                                            .headline6,
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
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).cardColor,
                                                  borderRadius: const BorderRadius.only(
                                                    bottomLeft: Radius.circular(0),
                                                    bottomRight: Radius.circular(0),
                                                    topLeft: Radius.circular(0),
                                                    topRight: Radius.circular(30),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                  DateFormat('dd MMM yyyy  hh:mm a').format(DateTime.now()),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontFamily: 'Lato',
                                                          // color: Colors.blue,
                                                          // fontSize: 12,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          */
                                    ///design 2
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 20, 0, 0),
                                          child: Container(
                                            width: double.infinity,
                                            // height: 70,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                              border: Border.all(),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                'Received  Rs. ${received.recivedAmount}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .greenAccent
                                                                    .withOpacity(
                                                                        0.2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40),
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    'Received',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                          fontFamily:
                                                                              'Lato',
                                                                          color:
                                                                              Colors.green,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   mainAxisSize:
                                                        //       MainAxisSize.max,
                                                        //   children: [
                                                        //     Expanded(
                                                        //       child: Padding(
                                                        //         padding:
                                                        //             const EdgeInsetsDirectional
                                                        //                     .fromSTEB(
                                                        //                 0,
                                                        //                 5,
                                                        //                 0,
                                                        //                 0),
                                                        //         child: Text(
                                                        //           'description : Send me my next Payment',
                                                        //           style: Theme.of(
                                                        //                   context)
                                                        //               .textTheme
                                                        //               .headline6,
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .mark_chat_unread_outlined,
                                                              size: 15,
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        0,
                                                                        0),
                                                                child: Text(
                                                                  (received.adminComments ??
                                                                          '')
                                                                      .capitalize!,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline6,
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
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(1),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(30),
                                              bottomRight: Radius.circular(0),
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              DateFormat(
                                                      'dd MMM yyyy   hh:mm a')
                                                  .format(DateTime.parse(
                                                      received.receiveDate!)),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontFamily: 'Lato',
                                                    color: Colors.white,
                                                    // fontSize: 12,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        /*
                          Align(
                            alignment: const AlignmentDirectional(0.79, 0.95),
                            child: ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              child: const Text('+ Request'),
                              style: ElevatedButton.styleFrom(
                                // width: 130,
                                // height: 40,
                                backgroundColor: Theme.of(context).primaryColor,
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2!.copyWith(
                                          fontFamily: 'Lato',
                                          color: Colors.white,
                                        ),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ),
                          */
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}

class DateFilterSheet extends StatefulWidget {
  const DateFilterSheet({Key? key, required this.type}) : super(key: key);
  final HistoryType type;

  @override
  State<DateFilterSheet> createState() => _DateFilterSheetState();
}

class _DateFilterSheetState extends State<DateFilterSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentsHistoryProvider>(builder: (context, php, _) {
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
                          php.filterData = {};
                          php.filterApplied = false;
                          setState(() {});
                          widget.type == HistoryType.received
                              ? await php
                                  .getReceived()
                                  .then((value) => Get.back())
                              : widget.type == HistoryType.request
                                  ? await php
                                      .getRequests()
                                      .then((value) => Get.back())
                                  : await php
                                      .getWithdraws()
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
                                DateFormat('dd MMM yyyy').format(php.fromDate)),
                            IconButton(
                                onPressed: () {
                                  php.searchWidget(
                                      list: php.receives,
                                      field: 'fd',
                                      context: context);
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
                                DateFormat('dd MMM yyyy').format(php.toDate)),
                            IconButton(
                                onPressed: () {
                                  php.searchWidget(
                                      list: php.receives,
                                      field: 'td',
                                      context: context);
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
                              php.filterApplied = true;
                              php.filterData.addAll({
                                'from_date':
                                    php.fromDate.toString().split(' ').first,
                                'to_date':
                                    php.toDate.toString().split(' ').first,
                                "keyword": ""
                              });
                              widget.type == HistoryType.received
                                  ? await php
                                      .getReceived()
                                      .then((value) => Get.back())
                                  : widget.type == HistoryType.request
                                      ? await php
                                          .getRequests()
                                          .then((value) => Get.back())
                                      : await php
                                          .getWithdraws()
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
