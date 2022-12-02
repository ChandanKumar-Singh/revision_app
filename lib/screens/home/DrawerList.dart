import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:revision/providers/ThemeProvider.dart';
import 'package:revision/screens/pages/MyIncome/directIncome.dart';
import 'package:revision/screens/pages/giftPacks/GiftPage.dart';
import 'package:revision/screens/pages/myPaidPayments.dart';

import '../../constants/widgets.dart';
import '../pages/myTeam.dart';
import '../pages/paymentRequests/paymentRequests.dart';
import '../pages/paymentRequests/recievedPayment.dart';
import '../pages/paymentRequests/withdrawalPayment.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  onTap: () {
                    Get.to(const UserslistWidget());
                  },
                  hoverColor: Colors.red,
                  selectedColor: Colors.red,
                  title: Text(
                    'My Team',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.supervised_user_circle_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: () {
                    Get.to(const MyPaidPaymentsWidget());
                  },
                  tileColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  hoverColor: Colors.red,
                  selectedColor: Colors.red,
                  title: Text(
                    'Paid Payments',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    collapsedBackgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                    collapsedIconColor: Colors.white,
                    title: Text(
                      'My Income',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
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
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        leading: const Icon(Icons.assistant_direction,color: Colors.white,),
                      ),
                      ListTile(
                        onTap: () {},
                        hoverColor: Colors.red,
                        selectedColor: Colors.red,
                        title: Text(
                          'Referral Income',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.share_arrival_time_outlined,color: Colors.white,),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(const GiftPage());
                        },
                        title: Text(
                          'Gift Pack',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.card_giftcard_rounded,color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    collapsedBackgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                    collapsedIconColor: Colors.white,
                    leading: const Icon(Icons.monetization_on),
                    title: Text(
                      'Payments History',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                    children: [
                      ListTile(
                        onTap: () {
                          Get.to(const ReceivedPaymentsPage());
                        },
                        title: h6Text(
                          'Received',
                          color: Colors.white,
                        ),
                        leading: const Icon(Icons.move_to_inbox_rounded,color: Colors.white,),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(const RequestedPaymentsPage());
                        },
                        hoverColor: Colors.red,
                        selectedColor: Colors.red,
                        title: Text(
                          'Payment Requests',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.request_quote_outlined,color: Colors.white,),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(const WithDrawPaymentsPage());
                        },
                        hoverColor: Colors.red,
                        selectedColor: Colors.red,
                        title: Text(
                          'Withdrawals',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.price_check_outlined,color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
