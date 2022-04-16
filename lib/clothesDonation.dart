// ignore_for_file: file_names, non_constant_identifier_names, prefer_if_null_operators
// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new

import 'dart:convert';
import 'package:dashboard_final/models/clothesCartModel.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './headingWidget.dart';

class ConfirmClothesDonation extends StatefulWidget {
  int donorId;
  int ngoId;
  final ValueSetter<ClothesModel> _valueSetter;

  ConfirmClothesDonation(this.donorId, this.ngoId, this._valueSetter);
  @override
  State<ConfirmClothesDonation> createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmClothesDonation> {
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

  TextEditingController athctrl = TextEditingController();

  TextEditingController btitle = TextEditingController();

  String date = "";
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                HeadingWidget('Confirm Donation'),
                formWidget('Donation',
                    'Enter donation eg:"Black pant","Black shirt"', donation),
                formWidget(
                    'Quantity', 'Enter donation Quantity eg:"3","4"', quantity),
                formWidget('Note to NGO (optional)', 'Type here...', note),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            showTitleActions: true, onChanged: (date) {
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date) {
                          setState(() {
                            _time = "${date.hour}:${date.minute}";
                          });
                        }, currentTime: DateTime.now());
                      },
                      child: Text('SELECT TIME'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      'Pickup Time: $_time',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                          color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  'Clothes For',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                Center(child: BookList()),
                Divider(),
                _mySelection == "Kids" ? Course() : SizedBox(),
                _mySelection == "Adults" ? Adult() : SizedBox(),
                Divider(),
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
                        onPressed: () {
                          String foodType = _mySelection!;
                          String time = _time;
                          List<ClothesModel> products = [
                            ClothesModel(
                                donation.text,
                                quantity.text,
                                note.text,
                                _mySelection!,
                                course == null ? Size! : course!,
                                board == null ? adlt! : board!,
                                category!,
                                time,
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                          ];
                          widget._valueSetter(products[0]);
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 20,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _time = "";

  String? _mySelection;
  List foodtype = ['Kids', 'Adults'];
  Widget BookList() {
    return DropdownButton<String>(
      hint: Text('Select Category'),
      items: foodtype.map((item) {
        return new DropdownMenuItem(
          child: new Text(
            item,
          ),
          value: item.toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _mySelection = val.toString();
        });
      },
      value: _mySelection,
    );
  }

  String? course;
  List coursetype = [
    '0-3 months',
    '3-6 months',
    '6-12 months',
    '12-24 months',
    '2-3 years',
    '4-5 years',
    '6-7 years',
    '8-9 years',
    '10-11 years',
    '12-13 years'
  ];
  Widget CourseList() {
    return DropdownButton<String>(
      hint: Text('Select Category'),
      items: coursetype.map((item) {
        return new DropdownMenuItem(
          child: new Text(
            item,
          ),
          value: item.toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          course = val.toString();
        });
      },
      value: course,
    );
  }

  String? board;
  List boardList = ['boy', 'girl'];
  Widget BoardList() {
    return DropdownButton<String>(
      hint: Text('Select Category'),
      items: boardList.map((item) {
        return new DropdownMenuItem(
          child: new Text(
            item,
          ),
          value: item.toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          board = val.toString();
        });
      },
      value: board,
    );
  }

  String? Size;
  List sizeList = ['small', 'medium', 'large', 'XL', 'XXL'];
  Widget SizeList() {
    return DropdownButton<String>(
      hint: Text('Select Size'),
      items: sizeList.map((item) {
        return new DropdownMenuItem(
          child: new Text(
            item,
          ),
          value: item.toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          Size = val.toString();
        });
      },
      value: Size,
    );
  }

  String? category;
  List categoryList = [
    'Shirts or tops',
    'Jeans or Bottoms',
    'Sleepwear',
    'Shalwar Kameez',
    'Pant Shirt',
    'Others'
  ];
  Widget CategoryList() {
    return DropdownButton<String>(
      hint: Text('Select Category'),
      items: categoryList.map((item) {
        return new DropdownMenuItem(
          child: new Text(
            item,
          ),
          value: item.toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          category = val.toString();
        });
      },
      value: category,
    );
  }

  String? adlt;
  List adltList = ['Women', 'Men'];
  Widget AdltList() {
    return DropdownButton<String>(
      hint: Text('Select Gender'),
      items: adltList.map((item) {
        return new DropdownMenuItem(
          child: new Text(
            item,
          ),
          value: item.toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          adlt = val.toString();
        });
      },
      value: adlt,
    );
  }

  Widget Adult() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Clothes Details',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            ),
          ),
          Center(
            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    AdltList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizeList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CategoryList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Course() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Clothes Details',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            ),
          ),
          Center(
            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CourseList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    BoardList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CategoryList(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future makeDontion() async {
    String url = 'https://edonations.000webhostapp.com/api-donate.php';
    var data = {
      'name': donation.text,
      'quantity': quantity.text,
      'note': note.text,
      'foodtype': _mySelection,
      // 'user_id': widget.donorId,
      // 'ngo_id': widget.ngoId,
      'available_time': _time.toString()
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
