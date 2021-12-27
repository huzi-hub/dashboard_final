// ignore_for_file: avoid_unnecessary_containers, file_names, prefer_const_constructors

import 'package:flutter/material.dart';

import 'donor_appbar.dart';

class HeadingWidget extends StatefulWidget {
  // final username;
  // final address;
  // final contact;
  // final email1;
  // final image;
  // final fow;
  // final desc;
  // final donoId;
  // final password;

  final String heading;
  HeadingWidget(
    this.heading,
    // this.address,
    // this.username,
    // this.contact,
    // this.email1,
    // this.image,
    // this.donoId,
    // this.fow,
    // this.desc,
    // this.password,
  );

  @override
  State<HeadingWidget> createState() => _HeadingWidgetState();
}

class _HeadingWidgetState extends State<HeadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Card(
        elevation: 0.0,
        child: Row(
          children: [
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.green,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => DonorAppBar(
                  //             widget.donoId,
                  //             widget.address,
                  //             widget.username,
                  //             widget.contact,
                  //             widget.email1,
                  //             widget.password,
                  //             widget.image,
                  //             widget.fow,
                  //             widget.desc)));
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 70,
              color: Colors.white,
              child: Text(
                widget.heading,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
