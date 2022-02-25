import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'Login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                height: 210,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SignUp',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Create an Account',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 25,
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 130,
                        width: 230,
                        child: Image(
                          image: AssetImage(
                            'assets/1.png',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 400,
                  width: 300,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                            fillColor: Colors.blue[800],
                            filled: true,
                            hintText: ('User Name'),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            fillColor: Colors.blue[800],
                            filled: true,
                            hintText: ('Email'),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.blue[800],
                            filled: true,
                            hintText: ('Password'),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: address,
                        decoration: InputDecoration(
                            fillColor: Colors.blue[800],
                            filled: true,
                            hintText: ('Address'),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: contact,
                        decoration: InputDecoration(
                            fillColor: Colors.blue[800],
                            filled: true,
                            hintText: ('Contact Number'),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    register();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have Acccount?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 15,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future register() async {
    String url = 'https://edonations.000webhostapp.com/api-signup.php';
    var data = {
      'username': username.text,
      'email': email.text,
      'password': password.text,
      'address': address.text,
      'contact': contact.text
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    //var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Can not register')));
    }
  }
}
