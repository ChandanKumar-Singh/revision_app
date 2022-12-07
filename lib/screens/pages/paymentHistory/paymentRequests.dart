import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:gsform/gs_form/widget/form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revision/screens/pages/paymentHistory/recievedPayment.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../constants/widgets.dart';
import '../../../providers/PaymentsHistoryProvider.dart';

class RequestedPaymentsPage extends StatefulWidget {
  const RequestedPaymentsPage({Key? key}) : super(key: key);

  @override
  _RequestedPaymentsPageState createState() => _RequestedPaymentsPageState();
}

class _RequestedPaymentsPageState extends State<RequestedPaymentsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void init() async {
    await Provider.of<PaymentsHistoryProvider>(context, listen: false)
        .getRequests();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<bool> willPop() async {
    var php = Provider.of<PaymentsHistoryProvider>(context, listen: false);
    php.requests.clear();
    php.totalRequests = 0;
    php.loadingRequests = false;
    php.filterApplied = false;
    php.filterData.clear();
    php.fromDate = DateTime.now().subtract(const Duration(days: 1));
    php.toDate = DateTime.now();
    debugPrint('On will pop withdraws length ${php.receives.length} ');
    return true;
  }

  late GSForm form;

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
                stops: [0, 1],
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
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const DateFilterSheet(
                                    type: HistoryType.request,
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
                  // iconTheme:
                  // IconThemeData(color: Theme.of(context).colorScheme.primary),

                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/prequest.jpg',
                      // 'assets/gift/gift-13.gif',
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    centerTitle: true,
                    expandedTitleScale: 1.2,
                    title: const Text('Payment Requests'),
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
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: php.requests.length,
                            itemBuilder: (context, i) {
                              final request = php.requests[i];

                              int status = php.requests[i].paymentStatus!;

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
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 30, 0, 0),
                                        child: Container(
                                          width: double.infinity,
                                          // height: 70,
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(
                                            //   colors: [
                                            //     Theme.of(context)
                                            //         .colorScheme.secondary,
                                            //     Theme.of(context)
                                            //         .colorScheme.primary
                                            //   ],
                                            //   stops: [0, 1],
                                            //   begin: const AlignmentDirectional(
                                            //       0, -1),
                                            //   end: const AlignmentDirectional(
                                            //       0, 1),
                                            // ),
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
                                                              'Requested for Rs. ${request.requestedAmount}',
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
                                                            // width: 100,
                                                            // height: 30,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        5),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: status == 0
                                                                  ? Colors
                                                                      .yellow
                                                                      .withOpacity(
                                                                          0.2)
                                                                  : status == 1
                                                                      ? Colors
                                                                          .green
                                                                          .withOpacity(
                                                                              0.2)
                                                                      : Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                              border:
                                                                  Border.all(
                                                                color: status ==
                                                                        0
                                                                    ? Colors
                                                                        .yellow
                                                                    : status ==
                                                                            1
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red,
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
                                                                  status == 0
                                                                      ? 'Waiting'
                                                                      : status ==
                                                                              1
                                                                          ? "Received"
                                                                          : "Rejected",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                        fontFamily:
                                                                            'Lato',
                                                                        color: status ==
                                                                                0
                                                                            ? Colors.yellow
                                                                            : status == 1
                                                                                ? Colors.green
                                                                                : Colors.red,
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
                                                                'description : ${request.userComments}',
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
                                                                (request.adminComments ??
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
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 1,
                                              right: 1,
                                              bottom: 1,
                                              top: 1),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
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
                                                      request.requestedDate!)),
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
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.79, 0.95),
                          child: ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const RequestBottomSheet();
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              // width: 130,
                              // height: 40,
                              backgroundColor: Theme.of(context).primaryColor,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontFamily: 'Lato',
                                    // color: Colors.white,
                                  ),
                              side: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            child: const Text(
                              '+ Request',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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

class RequestBottomSheet extends StatefulWidget {
  const RequestBottomSheet({Key? key}) : super(key: key);

  @override
  State<RequestBottomSheet> createState() => _RequestBottomSheetState();
}

class _RequestBottomSheetState extends State<RequestBottomSheet> {
  TextEditingController manualController = TextEditingController(text: '2000');
  TextEditingController noteController = TextEditingController();
  int sliderAmount = 2000;
  bool manualAmount = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        height: Get.height * 0.5,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              h6Text('(Amount In Rs.)'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child:
                    // !manualAmount
                    //     ? SfSlider(
                    //         min: 0.0,
                    //         max: 100000.0,
                    //         value: sliderAmount,
                    //         interval: 20,
                    //         showTicks: false,
                    //         showLabels: false,
                    //         enableTooltip: true,
                    //         shouldAlwaysShowTooltip: true,
                    //         tooltipShape: const SfPaddleTooltipShape(),
                    //         thumbIcon: const Icon(Icons.add),
                    //         minorTicksPerInterval: 1,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             sliderAmount = (value as double).floor();
                    //             manualController.text = sliderAmount.toString();
                    //           });
                    //         },
                    //       )
                    //     :
                    TextFormField(
                            controller: manualController,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              prefixIcon: Icon(Icons.currency_rupee_rounded)
                            ),
                            onChanged: (val) {
                              sliderAmount =
                                  double.parse(manualController.text).floor();
                              setState(() {});
                            },
                          ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       manualAmount = !manualAmount;
                  //     });
                  //   },
                  //   icon: Icon(manualAmount
                  //       ? Icons.slideshow_rounded
                  //       : Icons.text_fields_rounded),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              h6Text('Note:'),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: noteController,
                          minLines:
                              6, // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                              fillColor: Colors.greenAccent,
                              hintText: 'Add some note here'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (sliderAmount < 0) {
                          Fluttertoast.showToast(
                              msg: 'Amount field is required');
                        } else if (noteController.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Note field is required');
                        } else {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await Provider.of<PaymentsHistoryProvider>(context,
                                  listen: false)
                              .requestPayment(
                                  amount: sliderAmount,
                                  note: noteController.text)
                              .then((value) async {
                            print('value $value');
                            if (value) {
                              Get.back();
                              Get.back();
                              await Provider.of<PaymentsHistoryProvider>(
                                      context,
                                      listen: false)
                                  .getRequests();
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Could\'nt submit the request');
                            }
                          });
                        }
                      },
                      child: const Text('Submit Request'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
