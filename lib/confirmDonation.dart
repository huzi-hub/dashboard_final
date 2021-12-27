// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';
import 'package:dashboard_final/donor_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './headingWidget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'nearbyNgo.dart';

class ConfirmDonation extends StatefulWidget {
  int donorId;
  int ngoId;

  ConfirmDonation(this.donorId, this.ngoId);
  @override
  State<ConfirmDonation> createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmDonation> {
  String? donorEmail;
  String? ngoEmail;
  formWidget(String text, String hint, TextEditingController ctrl) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: TextFormField(
              controller: ctrl,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController donation = TextEditingController();

  TextEditingController quantity = TextEditingController();

  TextEditingController note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              HeadingWidget('Confirm Donation'),
              formWidget(
                  'Donation', 'Enter donation eg:"books","curry"', donation),
              formWidget(
                  'Quantity', 'Enter donation Quantity eg:"3","4"', quantity),
              formWidget('Note to NGO (optional)', 'Type here...', note),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                        ),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () => makeDontion(),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future makeDontion() async {
    String url = 'https://edonations.000webhostapp.com/api-donate.php';
    var data = {
      'name': donation.text,
      'quantity': quantity.text,
      'note': note.text,
      'user_id': widget.donorId,
      'ngo_id': widget.ngoId
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg != null) {
        Navigator.of(context).pop();
      }
    } else {
      SnackBar(content: Text('Error Please Try Later!'));
    }
  }
}
