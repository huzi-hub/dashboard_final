// ignore_for_file: deprecated_member_use, file_names, prefer_const_constructors

import 'dart:convert';
import 'package:dashboard_final/donor_appbar.dart';
import 'package:dashboard_final/griddashboard.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                height: 300,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 25,
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        height: 200,
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
                  height: 250,
                  width: 300,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
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
                      SizedBox(height: 40),
                      TextFormField(
                        controller: passwordController,
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
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 300,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.blue[800],
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    LoginUser();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont Have Acccount?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text('SignUp')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future LoginUser() async {
    String url = 'https://edonations.000webhostapp.com/api-login.php';
    var data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (result.body.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Check Internet Connection!')));
      }
    } else if (result.body.contains('false')) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Username or Password!')));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DonorAppBar(
              int.parse(msg[0]['user_id']),
              msg[0]['address'],
              msg[0]['username'],
              msg[0]['contact'],
              msg[0]['email'],
              msg[0]['password'],
              msg[0]['image'])));
    }
  }
}
