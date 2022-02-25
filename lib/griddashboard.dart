// ignore_for_file: prefer_const_constructors

import 'package:dashboard_final/main.dart';
import 'package:flutter/material.dart';

import 'nearbyNgo.dart';

class Dashboard extends StatefulWidget {
  // final fow;
  final donorId;
  final username;
  final image;
  Dashboard(this.donorId, this.username, this.image);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 30, 25, 25),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.27,
            decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(80),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    offset: Offset(
                      10,
                      10,
                    ),
                    blurRadius: 20,
                    color: Colors.white,
                  )
                ]),
            child: Container(
              padding: EdgeInsets.only(left: 15, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 45,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  maxRadius: 40,
                                  backgroundImage:
                                      AssetImage('assets/images.png'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ListTile(
                                  title: Text(
                                    'Hello ${widget.username}',
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Welcome To E-Donation App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(35, 30, 15, 15),
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.17,
                padding: EdgeInsets.only(top: 19),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NearbyNgos(widget.donorId, 'food')));
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage('assets/food.jpg')),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: Color(0x2e5cb8).withOpacity(0.5),
                                )
                              ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Donate Food',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.height * 0.17,
                padding: EdgeInsets.only(top: 19),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 3,
                  //     offset: Offset(5, 5),
                  //     color: Color(0x2e5cb8).withOpacity(0.5),
                  //   )
                  // ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NearbyNgos(widget.donorId, 'clothes')));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage('assets/clothes.jpg')),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: Color(0x2e5cb8).withOpacity(0.5),
                                )
                              ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Donate Clothes',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(25, 15, 15, 15),
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.17,
              padding: EdgeInsets.only(top: 19),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              child: Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NearbyNgos(widget.donorId, 'books')));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage('assets/books.jpg')),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: Offset(5, 5),
                                color: Color(0x2e5cb8).withOpacity(0.5),
                              )
                            ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'Donation Books',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
