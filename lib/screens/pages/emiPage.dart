import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/widgets.dart';

import '../../providers/paidPaymentsProvider.dart';

class EmiPage extends StatefulWidget {
  const EmiPage({Key? key}) : super(key: key);

  @override
  State<EmiPage> createState() => _EmiPageState();
}

class _EmiPageState extends State<EmiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(FontAwesomeIcons.arrowLeft)),
                  ),
                ),
                Expanded(child: h5Text('Emi Detail')),
                Expanded(child: Container()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 100,
                    width: Get.width / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                      // border: Border.all(
                      //     color: Theme.of(context).textTheme.headline5!.color!),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        h6Text('Amount', color: Colors.white),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: h6Text(
                                NumberFormat.simpleCurrency(name: 'INR').format(
                                  double.parse(
                                      Provider.of<PaidPaymentsProvider>(context,
                                              listen: false)
                                          .totalAmount),
                                ),
                                textAlign: TextAlign.center, color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: Get.width / 2.5,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //     color: Theme.of(context).textTheme.headline5!.color!),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        h6Text('Total Tenure', color: Colors.white),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                child: h6Text(
                              '36 Months',
                              textAlign: TextAlign.center, color: Colors.white
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      h5Text('#',
                          fontWeight: FontWeight.bold, color: Colors.blue),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            h5Text('Date', fontWeight: FontWeight.bold, color: Colors.blue),
                            h5Text('Amount', fontWeight: FontWeight.bold, color: Colors.blue),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 2)
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ...List.generate(36, (index) => index).map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              h6Text('${e + 1}'),
                              const SizedBox(width: 15),
                              h6Text('Installment'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ((e + 1).toString().length) * 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                b1Text('On ${e + 1} May 2022'),
                                h6Text(NumberFormat.simpleCurrency(name: 'INR')
                                    .format(double.parse('4000'))),
                              ],
                            ),
                          ),
                          if (e < 35) const Divider(),
                        ],
                      ),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
