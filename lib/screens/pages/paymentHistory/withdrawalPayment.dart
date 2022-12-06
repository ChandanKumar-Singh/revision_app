import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WithDrawPaymentsPage extends StatefulWidget {
  const WithDrawPaymentsPage({Key? key}) : super(key: key);

  @override
  _WithDrawPaymentsPageState createState() => _WithDrawPaymentsPageState();
}

class _WithDrawPaymentsPageState extends State<WithDrawPaymentsPage> {
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
            actions: [],
            // iconTheme:
            //     IconThemeData(color: Theme.of(context).colorScheme.primary),

            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/withdraw.jpg',
                // 'assets/gift/gift-13.gif',
                width: double.infinity,
                fit: BoxFit.cover,
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
                              List.generate(10, (index) => index)
                                  .toList()
                                  .take(15)
                                  .toList();
                          return ListView.builder(
                            padding: EdgeInsets.zero,
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
                                            //     .colorScheme
                                            //     .primary
                                            //     .withOpacity(0.7),    Theme.of(context)
                                            //   .colorScheme
                                            //   .onBackground
                                            //   .withOpacity(0.7),],
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
                                                              'Requested for Rs. 30343000',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6!.copyWith(color: Theme.of(context).textTheme.headline6!.color!.withOpacity(0.5),
                                                            ),
                                                          ),),
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
                                                              color: const Color(
                                                                  0x94D1F8D4),
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
                                                                  DateFormat(
                                                                          'dd MMM yyyy   hh:mm a')
                                                                      .format(DateTime
                                                                          .now()),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .caption!
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
                                                            child: Text(
                                                              'Received for Rs. 3000',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6!.copyWith(color: Colors.green),
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
                                        // width: 100,
                                        // height: 30,
                                        decoration: BoxDecoration(
                                          // gradient: LinearGradient(
                                          //   colors: [
                                          //     Theme.of(context)
                                          //         .colorScheme.primary,
                                          //     Theme.of(context)
                                          //         .colorScheme.secondary
                                          //   ],
                                          //   stops: [0, 1],
                                          //   begin: const AlignmentDirectional(
                                          //       0, -1),
                                          //   end: const AlignmentDirectional(
                                          //       0, 1),
                                          // ),
                                          color: Theme.of(context).cardColor,
                                          // border: const Border(
                                          //   left: BorderSide(
                                          //     color: Colors.black,
                                          //   ),
                                          //   top: BorderSide(),
                                          //   right: BorderSide(),
                                          // ),

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
                                            DateFormat('dd MMM yyyy   hh:mm a')
                                                .format(DateTime.now()),
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
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
