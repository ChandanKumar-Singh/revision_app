import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/providers/ThemeProvider.dart';
import 'package:revision/providers/UserProvider.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:fl_chart/fl_chart.dart';

import 'HomeDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, up, _) {
      double heignt = Get.height;
      double weight = Get.width;

      return Consumer<ThemeProvider>(builder: (context, tp, _) {
        print(tp.themeMode);
        return Scaffold(
          key: _scaffoldKey,
          body: MyCustomUI(),
        );
      });
    });
  }
}

class MyCustomUI extends StatefulWidget {
  @override
  MyCustomUIState createState() => MyCustomUIState();
}

class MyCustomUIState extends State<MyCustomUI>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late ScrollController scrollController;
  bool scUp = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {
        if (scrollController.offset > 0) {
          scUp = true;
        } else {
          scUp = false;
        }
        print('hiiii  $scUp   $scrollController ');
      });
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double heignt = Get.height;

    return Consumer<UserProvider>(builder: (context, up, _) {
      return Scaffold(
        key: _scaffoldKey,
        // backgroundColor: Colors.grey.withOpacity(scUp ? 0.7 : 0.7),
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: Card(
            margin: const EdgeInsets.all(0),
            shadowColor: scUp ? Colors.grey : Colors.transparent,
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(scUp ? 20 : 0)),
            ),
            color: scUp
                ? Theme.of(context).scaffoldBackgroundColor.withOpacity(01)
                : Theme.of(context).colorScheme.primary.withOpacity(0.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'Menu',
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.menu,
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    Expanded(
                      child: h5Text(
                        // App.appname,
                        'Dashboard',

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        h6Text(
                          '15 May 2022',
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer: HomeDrawer(
            scaffoldKey: _scaffoldKey,
            height: heignt,
            up: up,
            onChangeTheme: () {
              Timer(const Duration(milliseconds: 500), () {
                setState(() {});
              });
            }),
        // backgroundColor: const Color(0xff2A40CE),

        body: Container(
          // color: Colors.grey.withOpacity(scUp ? 0.7 : 0.7),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: ListView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(height: w / 13),
                      Row(
                        children: [
                          h6Text(
                            'Payments Details',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Card(
                        elevation: 15,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(100),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 5,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              b1Text(
                                                'Total',
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .currency_rupee_rounded,
                                                    size: 15,
                                                  ),
                                                  b1Text(
                                                    '2000000',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Container(
                                            width: 5,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              b1Text(
                                                'Paid',
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .currency_rupee_rounded,
                                                    size: 15,
                                                  ),
                                                  b1Text(
                                                    '20000',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: DashBoardCircleProgress(),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 5,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            b1Text(
                                              'Due',
                                              fontWeight: FontWeight.bold,
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.currency_rupee_rounded,
                                                  size: 15,
                                                ),
                                                b1Text(
                                                  '20000',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 5,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            b1Text(
                                              'Last Paid',
                                              fontWeight: FontWeight.bold,
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month,
                                                  size: 15,
                                                ),
                                                const SizedBox(width: 5),
                                                b1Text(
                                                  '30 Dec 2022',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          h6Text(
                            'Gift Cards',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, i) {
                        return SizedBox(
                          width: 150,
                          child: Card(
                            elevation: 15,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(1),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                                topLeft: Radius.circular(7),
                                topRight: Radius.circular(100),
                              ),
                            ),
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: h6Text(
                                          'Smart Phone oro erut  ere epr effe ',
                                          maxLine: 3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: b1Text(
                                              'On Business of',
                                              maxLine: 3,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.currency_rupee_rounded,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                            child: h6Text(
                                              '300000',
                                              maxLine: 2,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          h6Text(
                            'Daily Overview',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        height: 500,
                        child: BarChartSample1(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      );
    });
  }
}

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * value).round(),
      (green * value).round(),
      (blue * value).round(),
    );
  }
}

class BarChartSample1 extends StatefulWidget {
  const BarChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  List<Color> get availableColors => const <Color>[
        Colors.purpleAccent,
        Colors.yellow,
        Colors.deepPurple,
        Colors.lightBlue,
        Colors.orange,
        Colors.pink,
        Colors.redAccent,
      ];

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Income',
                    style: TextStyle(
                      // color: Color(0xff0f4a3c),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Last 7 days overview',
                    style: TextStyle(
                      // color: Color(0xff379982),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: IconButton(
            //       icon: Icon(
            //         isPlaying ? Icons.pause : Icons.play_arrow,
            //         color: const Color(0xff0f4a3c),
            //       ),
            //       onPressed: () {
            //         setState(() {
            //           isPlaying = !isPlaying;
            //           if (isPlaying) {
            //             refreshState();
            //           }
            //         });
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Theme.of(context).colorScheme.primary : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary.darken())
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 30000,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 45544,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 35665,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 3655,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 93564,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 52016,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 36354,
                barColor: availableColors[i], isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay = DateFormat('dd MMM yyyy').format(DateTime.now());
            // switch (group.x) {
            //   case 0:
            //     weekDay = 'Monday';
            //     break;
            //   case 1:
            //     weekDay = 'Tuesday';
            //     break;
            //   case 2:
            //     weekDay = 'Wednesday';
            //     break;
            //   case 3:
            //     weekDay = 'Thursday';
            //     break;
            //   case 4:
            //     weekDay = 'Friday';
            //     break;
            //   case 5:
            //     weekDay = 'Saturday';
            //     break;
            //   case 6:
            //     weekDay = 'Sunday';
            //     break;
            //   default:
            //     throw Error();
            // }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      // color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
              barColor:
                  availableColors[Random().nextInt(availableColors.length)],
            );
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}

class DashBoardCircleProgress extends StatefulWidget {
  /// Creates the instance of MyHomePage
  DashBoardCircleProgress({Key? key}) : super(key: key);

  @override
  _DashBoardCircleProgressState createState() =>
      _DashBoardCircleProgressState();
}

class _DashBoardCircleProgressState extends State<DashBoardCircleProgress> {
  double progressValue = 30;
  Widget _getRadialGauge() {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
        minimum: 0, maximum: 150,
        // pointers: const <GaugePointer>[
        // RangePointer(
        //     value: 50,
        //     width: 0.1,
        //     sizeUnit: GaugeSizeUnit.factor,
        //     cornerStyle: CornerStyle.startCurve,
        //     gradient: SweepGradient(
        //         colors: <Color>[Color(0xFF00a9b5), Color(0xFFa4edeb)],
        //          stops: <double>[0.25, 0.75])),
        pointers: <GaugePointer>[const RangePointer(value: 20)],

        //     annotations: <GaugeAnnotation>[
        //   GaugeAnnotation(
        //       widget: Container(
        //         child: const Text(
        //           '90.0',
        //         ),
        //       ),
        //       angle: 90,
        //       positionFactor: 0.5)
        // ],
      ),
    ]);
  }

  Widget _getLinearGauge() {
    return Container(
      child: SfLinearGauge(
          minimum: 0.0,
          maximum: 100.0,
          orientation: LinearGaugeOrientation.horizontal,
          majorTickStyle: const LinearTickStyle(length: 20),
          axisLabelStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
          axisTrackStyle: const LinearAxisTrackStyle(
              color: Colors.cyan,
              edgeStyle: LinearEdgeStyle.bothFlat,
              thickness: 15.0,
              borderColor: Colors.grey)),
      margin: const EdgeInsets.all(10),
    );
  }

  /// Returns normal style circular progress bars.
  Widget getNormalProgressStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 120,
          width: 120,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                radiusFactor: 0.8,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.2,
                  cornerStyle: CornerStyle.bothCurve,
                  color: Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      cornerStyle: CornerStyle.bothCurve,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0.1,
                      angle: 90,
                      widget: Text(
                        progressValue.toStringAsFixed(0) + ' / 100',
                        style: const TextStyle(fontSize: 11),
                      ))
                ])
          ]),
        ),
        Container(
          height: 120,
          width: 120,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.05,
                  color: Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      width: 0.05,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0,
                      widget: Text(progressValue.toStringAsFixed(0) + '%'))
                ])
          ]),
        ),
      ],
    );
  }

  /// Returns filled track style circular progress bar.
  Widget getFilledTrackStyle() {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              axisLineStyle: const AxisLineStyle(
                thickness: 1,
                color: Color.fromARGB(255, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  value: progressValue,
                  width: 0.15,
                  enableAnimation: true,
                  animationDuration: 100,
                  color: Colors.white,
                  pointerOffset: 0.1,
                  cornerStyle: CornerStyle.bothCurve,
                  animationType: AnimationType.linear,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0.5,
                    widget: Text(progressValue.toStringAsFixed(0) + '%',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)))
              ])
        ]));
  }

  /// Returns filled progress style circular progress bar.
  Widget getFilledProgressStyle() {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.8,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.05,
              color: Color.fromARGB(100, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: progressValue,
                width: 0.95,
                pointerOffset: 0.05,
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationType: AnimationType.linear,
                animationDuration: 100,
              )
            ],
          )
        ]));
  }

  /// Returns gradient progress style circular progress bar.
  Widget getGradientProgressStyle() {
    return SizedBox(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.1,
                color: Color.fromARGB(30, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
                cornerStyle: CornerStyle.startCurve,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                    value: progressValue,
                    width: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationDuration: 100,
                    animationType: AnimationType.linear,
                    cornerStyle: CornerStyle.startCurve,
                    gradient: SweepGradient(colors: <Color>[
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ], stops: <double>[
                      0.25,
                      0.75
                    ])),
                MarkerPointer(
                  value: progressValue,
                  markerType: MarkerType.circle,
                  enableAnimation: true,
                  animationDuration: 100,
                  animationType: AnimationType.linear,
                  color: const Color(0xFF87e8e8),
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0,
                    widget: Text(progressValue.toStringAsFixed(0) + '%'))
              ]),
        ]));
  }

  /// Returns thick progress style circular progress bar.
  Widget getThickProgressStyle() {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.75,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.05,
              color: Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: progressValue,
                width: 0.2,
                pointerOffset: -0.08,
                enableAnimation: true,
                animationDuration: 100,
                animationType: AnimationType.linear,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ],
          )
        ]));
  }

  /// Returns semi-circular style circular progress bar.
  Widget getSemiCircleProgressStyle() {
    return Container(
        height: 120,
        width: 120,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 180,
              canScaleToFit: true,
              endAngle: 0,
              radiusFactor: 0.8,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.1,
                color: Color.fromARGB(30, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
                cornerStyle: CornerStyle.startCurve,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                    value: progressValue,
                    width: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationDuration: 100,
                    animationType: AnimationType.linear,
                    cornerStyle: CornerStyle.startCurve)
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0,
                    widget: Text(progressValue.toStringAsFixed(0) + '%'))
              ]),
        ]));
  }

  /// Returns segmented line style circular progress bar.
  Widget getSegmentedProgressStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 120,
            width: 120,
            child: SfRadialGauge(axes: <RadialAxis>[
              // Create primary radial axis
              RadialAxis(
                minimum: 0,
                interval: 1,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.2,
                  color: Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      width: 0.05,
                      pointerOffset: 0.07,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
              ),
              // Create secondary radial axis for segmented line
              RadialAxis(
                minimum: 0,
                interval: 1,
                maximum: 4,
                showLabels: false,
                showTicks: true,
                showAxisLine: false,
                tickOffset: -0.05,
                offsetUnit: GaugeSizeUnit.factor,
                minorTicksPerInterval: 0,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                majorTickStyle: const MajorTickStyle(
                    length: 0.3,
                    thickness: 3,
                    lengthUnit: GaugeSizeUnit.factor,
                    color: Colors.white),
              )
            ])),
        Container(
          height: 120,
          width: 120,
          child: SfRadialGauge(axes: <RadialAxis>[
            // Create primary radial axis
            RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                radiusFactor: 0.8,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.3,
                  color: Color.fromARGB(40, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      width: 0.3,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0.2,
                      horizontalAlignment: GaugeAlignment.center,
                      widget: Text(progressValue.toStringAsFixed(0) + '%'))
                ]),
            // Create secondary radial axis for segmented line
            RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              showAxisLine: true,
              tickOffset: -0.05,
              offsetUnit: GaugeSizeUnit.factor,
              minorTicksPerInterval: 0,
              radiusFactor: 0.8,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.3,
                color: Colors.white,
                dashArray: <double>[4, 3],
                thicknessUnit: GaugeSizeUnit.factor,
              ),
            )
          ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return getGradientProgressStyle();
  }
}
