import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReceivedPaymentsPage extends StatefulWidget {
  const ReceivedPaymentsPage({Key? key}) : super(key: key);

  @override
  _ReceivedPaymentsPageState createState() => _ReceivedPaymentsPageState();
}

class _ReceivedPaymentsPageState extends State<ReceivedPaymentsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.green));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // SystemChrome.setSystemUIOverlayStyle(
    // SystemUiOverlayStyle(statusBarColor: Theme.of(context).cardColor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).cardColor.withOpacity(0.9),
      body: NestedScrollView(
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
            actions: [],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/precieved.jpg',
                // 'assets/gift/gift-13.gif',
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              centerTitle: true,
              expandedTitleScale: 1.2,
              titlePadding:
                  const EdgeInsetsDirectional.fromSTEB(50, 10, 10, 10),
              title: SizedBox(
                height: 30,
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  // spacing: 10,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Chip(
                        label: Text(
                          'selecet',
                          textScaleFactor: 1,
                        ),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Chip(
                        label: Text('selecet'),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Chip(
                        label: Text('selecet'),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Chip(
                        label: Text('selecet'),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Chip(
                        label: Text('selecet'),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Chip(
                        label: Text('selecet'),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Chip(
                        label: Text('selecet'),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Chip(
                        label: Text('selecet'),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Chip(
                        label: Text('selecet'),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                          Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(1),
                        ],
                        stops: [0, 1],
                        begin: const AlignmentDirectional(0, -1),
                        end: const AlignmentDirectional(0, 1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Builder(
                        builder: (context) {
                          final requestCard =
                              List.generate(10, (index) => index).toList();
                          return ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: requestCard.length,
                            itemBuilder: (context, requestCardIndex) {
                              final requestCardItem =
                                  requestCard[requestCardIndex];

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
                                            color: Theme.of(context).cardColor,
                                            border: Border.all(),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
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
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              'Received  Rs. 30000',
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
                                                              color: Colors.greenAccent.withOpacity(0.2),
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
                                                                        color:Colors.green,
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
                                          color:
                                              Colors.greenAccent.withOpacity(1),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            DateFormat('dd MMM yyyy   hh:mm a')
                                                .format(DateTime.now()),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontFamily: 'Lato',
                                                  color: Colors.black,
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
    );
  }
}
