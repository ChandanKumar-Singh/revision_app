import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:revision/providers/ThemeProvider.dart';
import 'package:revision/screens/pages/MyIncome/directIncome.dart';
import 'package:revision/screens/pages/giftPacks/GiftPage.dart';
import 'package:revision/screens/pages/myPaidPayments.dart';

import '../../constants/widgets.dart';
import '../pages/myTeam.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, tp, _) {
      var brt = tp.brightness;
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Get.to(const UserslistWidget());
                },
                hoverColor: Colors.red,
                selectedColor: Colors.red,
                title: Text(
                  'My Team',
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: const Icon(Icons.supervised_user_circle_sharp),
              ),
              ListTile(
                onTap: () {
                  Get.to(const MyPaidPaymentsWidget());
                },
                hoverColor: Colors.red,
                selectedColor: Colors.red,
                title: Text(
                  'Paid Payments',
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: const Icon(Icons.payment),
              ),
              ExpansionTile(
                title: Text(
                  'My Income',
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: const Icon(Icons.monetization_on),
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(const DirectIncome());

                    },
                    title: Hero(
                      tag: 'Direct Income',
                      child: Text(
                        'Direct Income',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    leading: const Icon(Icons.assistant_direction),
                  ),
                  ListTile(
                    onTap: () {},
                    hoverColor: Colors.red,
                    selectedColor: Colors.red,
                    title: Text(
                      'Referral Income',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: const Icon(Icons.share_arrival_time_outlined),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(GiftPage());
                    },
                    title: Text(
                      'Gift Pack',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: const Icon(Icons.card_giftcard_rounded),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  'Payments History',
                  style: Theme.of(context).textTheme.headline6,
                ),
                children: [
                  ListTile(
                    onTap: () {},
                    title: h6Text(
                      'Received',
                    ),
                    leading: const Icon(Icons.move_to_inbox_rounded),
                  ),
                  ListTile(
                    onTap: () {},
                    hoverColor: Colors.red,
                    selectedColor: Colors.red,
                    title: Text(
                      'Payment Requests',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: const Icon(Icons.request_quote_outlined),
                  ),
                  ListTile(
                    onTap: () {},
                    hoverColor: Colors.red,
                    selectedColor: Colors.red,
                    title: Text(
                      'Withdrawals',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: const Icon(Icons.price_check_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
