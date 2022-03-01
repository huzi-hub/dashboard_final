import 'package:dashboard_final/Login.dart';
import 'package:dashboard_final/bookDonation.dart';
import 'package:dashboard_final/changepassword.dart';
import 'package:dashboard_final/donor_appbar.dart';
import 'package:dashboard_final/foodDonation.dart';
import 'package:dashboard_final/griddashboard.dart';
import 'package:dashboard_final/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConfirmBookDonation(),
    );
  }
}
