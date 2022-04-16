// ignore_for_file: file_names
// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new

import 'dart:convert';
import 'package:dashboard_final/models/booksCartModel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import './headingWidget.dart';
import 'models/donationCartModel.dart';

class ConfirmBookDonation extends StatefulWidget {
  int donorId;
  int ngoId;
  final ValueSetter<BooksModel> _valueSetter;

  ConfirmBookDonation(this.donorId, this.ngoId, this._valueSetter);
  @override
  State<ConfirmBookDonation> createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmBookDonation> {
  String? donorEmail;
  String? ngoEmail;

  List<Asset> images = [];
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 100,
          height: 100,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

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
                formWidget(
                    'Donation', 'Enter donation eg:"books","curry"', donation),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Text(
                    "Quantity",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextFormField(
                    controller: quantity,
                    decoration: InputDecoration(
                      hintText: 'Enter donation Quantity eg:"3","4"',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ],
                  ),
                ),
                formWidget('Note to NGO (optional)', 'Type here...', note),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Text(
                    "Quantity",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                    ),
                  ),
                ),
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
                  height: 15,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        loadAssets();
                      },
                      child: Text('Pick Image'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 120,
                      width: 400,
                      color: Color(0xffe6f7ff),
                      child: buildGridView(),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  'Book Category',
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
                _mySelection == "Course" ? Course() : SizedBox(),
                _mySelection == "Others" ? BookDetails() : SizedBox(),
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
                          List<BooksModel> products = [
                            BooksModel(
                                donation.text,
                                quantity.text,
                                note.text,
                                _mySelection!,
                                course == null ? btitle.text : course!,
                                board == null ? athctrl.text : board!,
                                time,
                                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}")
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
  List foodtype = ['Course', 'Others'];
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
    'pre',
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th',
    '9th',
    '10',
    '11',
    '12'
  ];
  Widget CourseList() {
    return DropdownButton<String>(
      hint: Text('Select Class'),
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
  List boardList = [
    'Sindh Board',
    'Punjab Board',
    'KPK board',
    'Balochistan Board',
    'Federal Board'
  ];
  Widget BoardList() {
    return DropdownButton<String>(
      hint: Text('Select Board'),
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

  Widget Course() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Course Details',
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
    String url = 'https://edonations.000webhostapp.com/api-donate-books.php';
    var data = {
      'name': donation.text,
      'quantity': quantity.text,
      'note': note.text,
      'book_type': _mySelection,
      'book_detail1': board,
      'book_detail2': course,
      'user_id': widget.donorId,
      'ngo_id': widget.ngoId,
      'available_time': _time.toString(),
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

  Widget BookDetails() {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          formWidget('Book title', 'Enter book title', btitle),
          formWidget('Book author', 'Enter book author name', athctrl)
        ],
      ),
    );
  }
}
