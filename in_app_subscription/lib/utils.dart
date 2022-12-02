import 'package:flutter/material.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';

class Utils {
  showSheet(
    BuildContext context, {
    required String title,
    required String description,
    required List<Package> packages,
    required void Function(Package package) onClickPackages,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  height: 400,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Center(
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Center(
                            child: Text(
                              description,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: ListView(
                        children: [
                          ...packages.map(
                            (e) => GestureDetector(
                              onTap: () {
                                onClickPackages(e);
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 100,
                                width: double.infinity,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                );
              });
        });
  }
}
