// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  final cart;
  final ngoId;
  final donorId;
  final fow;

  CheckoutScreen(this.cart, this.ngoId, this.donorId, this.fow);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.cart[index].name),
              trailing: Text(
                "${widget.cart[index].quantity}",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: widget.cart.length,
          shrinkWrap: true,
        ),
        Divider(),
        Center(
          child: ElevatedButton(
              onPressed: () {
                if (widget.fow == 'food') {
                  for (var i = 0; i < widget.cart.length; i++) {
                    print(widget.cart[i].date);
                    makeDontion(
                        widget.cart[i].name,
                        widget.cart[i].quantity,
                        widget.cart[i].note,
                        widget.cart[i].mySelection,
                        widget.donorId,
                        widget.ngoId,
                        widget.cart[i].time,
                        widget.cart[i].date);
                  }
                } else {
                  if (widget.fow == 'clothes') {
                    for (var i = 0; i < widget.cart.length; i++) {
                      clothDontion(
                          widget.cart[i].name,
                          widget.cart[i].quantity,
                          widget.cart[i].note,
                          widget.cart[i].clothes_for,
                          widget.cart[i].gender,
                          widget.cart[i].size,
                          widget.cart[i].clothe_type,
                          widget.donorId,
                          widget.ngoId,
                          widget.cart[i].time,
                          widget.cart[i].date);
                    }
                  } else {
                    for (var i = 0; i < widget.cart.length; i++) {
                      BooksDonation(
                          widget.cart[i].name,
                          widget.cart[i].quantity,
                          widget.cart[i].note,
                          widget.cart[i].book_type,
                          widget.cart[i].bookDetail1,
                          widget.cart[i].bookDetail2,
                          widget.donorId,
                          widget.ngoId,
                          widget.cart[i].time,
                          widget.cart[i].date);
                    }
                  }
                }
              },
              child: Text('Donate')),
        )
      ],
    );
  }

  Future makeDontion(String donation, String quantity, String note,
      String foodtype, int donorId, int ngoId, String time, String date) async {
    String url = 'https://edonations.000webhostapp.com/api-donate.php';
    var data = {
      'name': donation,
      'quantity': quantity,
      'note': note,
      'date': date,
      'food_type': foodtype,
      'user_id': widget.donorId,
      'ngo_id': widget.ngoId,
      'available_time': time.toString()
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg["status"] == true) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('You Donated successfully!')));
      }
    } else {
      SnackBar(content: Text('Error Please Try Later!'));
    }
  }

  Future clothDontion(
      String donation,
      String quantity,
      String note,
      String clothes_for,
      String gender,
      String size,
      String clothType,
      int donorId,
      int ngoId,
      String time,
      String date) async {
    String url = 'https://edonations.000webhostapp.com/api-donate_clothes.php';
    var data = {
      'name': donation,
      'quantity': quantity,
      'note': note,
      'date': date,
      'clothes_for': clothes_for,
      'gender': gender,
      'size': size,
      'clothe_type': clothType,
      'user_id': widget.donorId,
      'ngo_id': widget.ngoId,
      'available_time': time.toString()
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg["status"] == true) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('You Donated successfully!')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error!! Please try again later')));
    }
  }

  Future BooksDonation(
      String donation,
      String quantity,
      String note,
      String book_type,
      String board,
      String course,
      int donorId,
      int ngoId,
      String time,
      String date) async {
    String url = 'https://edonations.000webhostapp.com/api-donate-books.php';
    var data = {
      'name': donation,
      'quantity': quantity,
      'note': note,
      'date': date,
      'book_type': book_type,
      'book_detail1': board,
      'book_detail2': course,
      'user_id': widget.donorId,
      'ngo_id': widget.ngoId,
      'available_time': time,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg["status"] == true) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('You Donated successfully!')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error!! Please try again later')));
    }
  }
}
