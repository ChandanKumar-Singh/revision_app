import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extend;
import 'package:revision/providers/myIncomeProvider.dart';

import 'directIncome.dart';

class GiftPage extends StatefulWidget {
  const GiftPage({Key? key}) : super(key: key);

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  void init() async {
    await Provider.of<MyIncomeProvider>(context, listen: false).getGifts(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

    Provider.of<MyIncomeProvider>(context, listen: false).gfScontroller =
        ScrollController()
          ..addListener(
              Provider.of<MyIncomeProvider>(context, listen: false).gfLoadMore);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Provider.of<MyIncomeProvider>(context, listen: false)
        .gfScontroller
        .removeListener(
            Provider.of<MyIncomeProvider>(context, listen: false).gfLoadMore);
    super.dispose();
  }

  Future<bool> willPop() async {
    var mip = Provider.of<MyIncomeProvider>(context, listen: false);
    // mip.gifts.clear();
    mip.totalGifts = 0;
    mip.loadingGifts = false;
    mip.filterApplied = false;
    mip.filterData.clear();
    mip.fromDate = DateTime.now().subtract(const Duration(days: 1));
    mip.toDate = DateTime.now();
    debugPrint('On will pop gifts length ${mip.gifts.length} ');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;

    return WillPopScope(
      onWillPop: willPop,
      child: Consumer<MyIncomeProvider>(builder: (context, mip, _) {
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
                      collapsedHeight: 100,
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
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return const MIDateFilterSheet(
                                        type: IncomeType.gift,
                                      );
                                    });
                              },
                              icon: Stack(
                                children: [
                                  const Icon(Icons.filter_list),
                                  if (mip.filterApplied)
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
                        ],
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Row(
                          children: [
                            Expanded(
                              child: h6Text('Dear\nChandan Kumar Singh',
                                  textAlign: TextAlign.center,
                                  color: Colors.white),
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
                        child: Stack(
                          children: [
                            ListView.builder(
                              controller: mip.gfScontroller,
                              itemCount: mip.gifts.length,
                              padding: const EdgeInsets.only(bottom: 20),
                              itemBuilder: (context, i) {
                                var gift = mip.gifts[i];
                                var fromDate = DateFormat('MMM dd, yyyy')
                                    .format(DateTime.parse(gift.fromDate!));
                                var toDate = DateFormat('MMM dd, yyyy')
                                    .format(DateTime.parse(gift.toDate!));

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
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(0.9),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 5),
                                                child: h6Text(
                                                  fromDate,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.9),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 0),
                                                    child: h6Text('-',
                                                        color: Colors.white))),
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.9),
                                                ),
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 5),
                                                    child: h6Text(toDate,
                                                        color: Colors.white))),
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: gift.status == 0
                                                    ? Colors.orange
                                                    : Colors.green,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  gift.status == 0
                                                      ? Icons
                                                          .watch_later_outlined
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

                                            h6Text(
                                            NumberFormat.simpleCurrency(name: 'INR').format(double.parse(gift.totalBusiness ?? '0')),
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
                                                'You won a ${gift.giftPack}',
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 30)
                                          ],
                                        ),
                                      ),
                                      // Spacer(),
                                      gift.comments != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.send,
                                                    color: Colors.green,
                                                  ),
                                                  Expanded(
                                                    child: h6Text(
                                                      gift.comments ?? '---',
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 30)
                                                ],
                                              ),
                                            )
                                          : SizedBox(height: 7),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 8.0, vertical: 5),
                                      //   child: Row(
                                      //     children: [
                                      //       Expanded(
                                      //         child: h6Text(
                                      //           'Your gift has released on $expiryDate',
                                      //           textAlign: TextAlign.center,
                                      //         ),
                                      //       ),
                                      //       const SizedBox(width: 30)
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            if (mip.isGfLoadMoreRunning)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 18.0),
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
