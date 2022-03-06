import 'package:dashboard_final/foodDonation.dart';
import 'package:dashboard_final/models/donationCartModel.dart';

import 'donationBox.dart';
import 'models/donationsModel.dart';
import 'package:flutter/material.dart';

class CartApp extends StatefulWidget {
  @override
  _CartAppState createState() => _CartAppState();
}

class _CartAppState extends State<CartApp> {
  List<ProductModel> cart = [];
  int sum = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.green,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text("Confirm Donation"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Donation",
              ),
              Tab(
                text: "Donation Box",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ConfirmFoodDonation(1, 1, (selectedProduct) {
              setState(() {
                cart.add(selectedProduct); //update
              });
            }),
            CheckoutScreen(cart, sum),
          ],
        ),
      ),
    );
  }
}
