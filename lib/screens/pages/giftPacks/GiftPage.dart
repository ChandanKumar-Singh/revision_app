import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extend;

class GiftPage extends StatefulWidget {
  const GiftPage({Key? key}) : super(key: key);

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(Theme.of(context).colorScheme.primary.value),
              Color(Theme.of(context).cardColor.value),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: extend.ExtendedNestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  titleSpacing: 20,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          Get.back();
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () async {},
                      ),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Row(
                      children: [
                        Expanded(
                          child: h6Text('Dear\nChandan Kumar Singh',
                              textAlign: TextAlign.center, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: h6Text('You have unlocked these gifts.',
                          textAlign: TextAlign.center, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                      itemCount: 10,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, i) {
                        var fromDate = DateFormat('MMM dd, yyyy')
                            .format(DateTime.now().subtract(Duration(days: i)));
                        var toDate = DateFormat('MMM dd, yyyy')
                            .format(DateTime.now().subtract(Duration(days: i)));
                        var expiryDate = DateFormat('MMM dd, yyyy')
                            .format(DateTime.now().subtract(Duration(days: i)));
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          // height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).cardColor,
                            backgroundBlendMode: BlendMode.src,
                            // image: DecorationImage(
                            //   opacity: i < 4 ? 0.9 : 0.4,
                            //   colorFilter: ColorFilter.mode(
                            //       i < 4 ? Colors.transparent : Colors.black12,
                            //       BlendMode.color),
                            //   image: const AssetImage(
                            //     // 'assets/gift/1607444722_664485.gif',
                            //     'assets/gift/IllegalLimitedBettong-size_restricted.gif',
                            //   ),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    h6Text(fromDate),
                                    h6Text('-'),
                                    h6Text(toDate),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: i < 4
                                            ? Colors.orange
                                            : Colors.green,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          i < 4
                                              ? Icons.watch_later_outlined
                                              : Icons.done,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5),
                                child: Row(
                                  children: [
                                    h6Text(
                                      'Total Business : ',
                                      textAlign: TextAlign.center,
                                    ),
                                    const Icon(
                                      Icons.currency_rupee_rounded,
                                      size: 15,
                                    ),
                                    h6Text(
                                      '5000000.00',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: h6Text(
                                        'You won a Mobile Device',
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 30)
                                  ],
                                ),
                              ),
                              // Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: h6Text(
                                        '# testing ',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    const SizedBox(width: 30)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: h6Text(
                                        'Your gift has released on $expiryDate',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(width: 30)
                                  ],
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
