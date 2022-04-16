// ignore_for_file: deprecated_member_use, file_names, prefer_const_constructors, unused_label, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:typed_data';
import 'donor_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<String> pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? _imagePicker =
      await _picker.pickImage(source: ImageSource.gallery);
  // XFile is now recommended to use with ImagePicker
  // File? _imagePicker;

  // This Line of Code will pick the image from your gallery
  // _imagePicker =
  //     await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 1);

  //Our XFile variable is nullable so we've to check if we've picked the image or not
  if (_imagePicker != null) {
    // Now we're converting our image into Uint8List
    Uint8List bytes = await _imagePicker.readAsBytes();

    // Here we're converting our image to Base64
    String encode = base64Encode(bytes);

    // Returning Base64 Encoded Image
    return encode;
  } else {
    if (kDebugMode) {
      print('Pick Image First');
    }
    return 'Error';
  }
}

// Future registration({
//   // required String username,
//   // required String fullname,
//   // required String password,
//   required String image,
// }) async {
//   try {
//     final response = await http.post(
//       Uri.parse(uploadAPI),
//       body: {
//         'image': image,
//         //   'username': username,
//         //   'password': password,
//         //   'fullName': fullname,
//       },
//     );

//     if (response.statusCode == 200) {
//       final result = json.decode(response.body);
//       return result;
//     } else {
//       if (kDebugMode) {
//         print('Error 1');
//       }
//       return 'Error';
//     }
//   } catch (e) {
//     return 'Error';
//   }
// }

class EditProfile extends StatefulWidget {
  final username;
  final address;
  final contact;
  final email1;
  final image;
  final donoId;
  final password;

  const EditProfile(this.address, this.username, this.contact, this.email1,
      this.image, this.donoId, this.password);

  @override
  _EditProfileState createState() => _EditProfileState();
}

// late final username;
// late final contact;

class _EditProfileState extends State<EditProfile> {
  String localmage = '';
  TextEditingController usernamee = TextEditingController();
  TextEditingController contactt = TextEditingController();
  TextEditingController addresss = TextEditingController();
  TextEditingController image = TextEditingController();
  bool showPassword = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localmage = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Stack(
                  children: [
                    localmage.isNotEmpty
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                MemoryImage(base64Decode(localmage)),
                          )
                        : const CircleAvatar(
                            radius: 50,
                          ),
                    // Container(

                    //   child:
                    //    CircleAvatar(backgroundImage: NetworkImage(base64Encode(localmage)),),
                    //   // width: 130,
                    //   // height: 130,
                    //   // decoration: BoxDecoration(
                    //   //     border: Border.all(
                    //   //         width: 4,
                    //   //         color: Theme.of(context).scaffoldBackgroundColor),
                    //   //     boxShadow: [
                    //   //       BoxShadow(
                    //   //           spreadRadius: 2,
                    //   //           blurRadius: 10,
                    //   //           color: Colors.black.withOpacity(0.1),
                    //   //           offset: Offset(0, 10))
                    //   //     ],
                    //   //     shape: BoxShape.circle,
                    //   //     image: DecorationImage(

                    //   //         fit: BoxFit.cover,
                    //   //         image: NetworkImage(
                    //   //           "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                    //   //         ))),
                    // ),
                    InkWell(
                      onTap: () {
                        chooseImage();
                      },
                      child: Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.green,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 45,
              ),
              buildTextField("Full Name", widget.username, false, usernamee),
              SizedBox(
                height: 25,
              ),
              buildTextField("Address", widget.address, false, addresss),
              SizedBox(
                height: 25,
              ),
              buildTextField("Contact", widget.contact, true, contactt),
              SizedBox(
                height: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      updatedata();
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DonorAppBar(
                                  widget.donoId,
                                  widget.address,
                                  widget.username,
                                  widget.contact,
                                  widget.email1,
                                  widget.password,
                                  image.text)));
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () => chooseImage(),
                    child: const Text('Register'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController ctrl) {
    return TextField(
      obscureText: isPasswordTextField ? showPassword : false,
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.green,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      controller: ctrl,
    );
  }

  Future updatedata() async {
    String url = 'https://edonations.000webhostapp.com/api-updatedonor.php';
    var data = {
      'username': usernamee.text == "" ? widget.username : usernamee.text,
      'address': addresss.text == "" ? widget.address : addresss.text,
      'contact': contactt.text == "" ? widget.contact : contactt.text,
      'email': widget.email1,
      'image': localmage
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg[0] != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DonorAppBar(
                msg[0]['user_id'],
                msg[0]['address'],
                msg[0]['username'],
                msg[0]['contact'],
                msg[0]['email'],
                msg[0]['password'],
                msg[0]['image'])));
      }
    } else {
      SnackBar(content: Text('Not Registered!'));
    }
  }

  void chooseImage() async {
    localmage = await pickImage();
    setState(() {});
    if (localmage != null)
      image:
      localmage;
    // password: password.text,
    // fullname: fullName.text,
    // username: username.text,
  }

  Future LoginUser() async {
    String url = 'https://edonations.000webhostapp.com/api-login.php';
    var data = {
      'email': widget.email1,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg[0] != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DonorAppBar(
                msg[0]['user_id'],
                msg[0]['address'],
                msg[0]['username'],
                msg[0]['contact'],
                msg[0]['email'],
                msg[0]['password'],
                msg[0]['image'])));
      }
    } else {
      SnackBar(content: Text('Invalid Username or Password!'));
    }
  }
}
