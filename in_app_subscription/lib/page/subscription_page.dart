import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_subscription/api/purchaseApi.dart';
import 'package:in_app_subscription/utils.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Icon(
            Icons.lock,
            size: 50,
          ),
          Text('You are on free plan'),
          ElevatedButton(onPressed: () {}, child: Text('See Plans'))
        ],
      ),
    );
  }

  Future fetchOffers() async {
    final offerings = await PurchaseApi.fetchOffers();
    if (offerings.isEmpty) {
      Fluttertoast.showToast(msg: 'No Plans Found');
    } else {
      final offer = offerings.first;
      print('Offer: $offer');
      final packages = offerings
          .map((offeer) => offeer.availablePackages)
          .expand((pair) => pair)
          .toList();
      // ignore: use_build_context_synchronously
      Utils().showSheet(context,
          title: '⭐ Upgrade Your Plan',
          description: "Upgrade to a new plan to enjoy more benefits",
          packages: packages, onClickPackages: (package) async {
        debugPrint('package selected is  $package');
      });
    }
  }
}
