// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'Login.dart';
import 'Services/donationServices.dart';
import 'donationHistory.dart';
import 'contacts.dart';
import 'my_drawer_header.dart';
import 'notification.dart';
import './myprofile.dart';
import 'griddashboard.dart';

import 'EditProfile.dart';

final List<DonationData> donations = [];

class DonorAppBar extends StatefulWidget {
  final donorId;
  final username;
  final address;
  final contact;
  final email;
  final password;
  final image;
  final fow;
  final desc;
  DonorAppBar(this.donorId, this.address, this.username, this.contact,
      this.email, this.password, this.image, this.fow, this.desc);
  @override
  _DonorAppBar createState() => _DonorAppBar();
}

class _DonorAppBar extends State<DonorAppBar> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    Dashboard(
        widget.donorId, widget.fow, widget.desc, widget.username, widget.image);
  }

  var currentPage = DrawerSections.griddashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.griddashboard) {
      container = Dashboard(widget.donorId, widget.fow, widget.desc,
          widget.username, widget.image);
    } else if (currentPage == DrawerSections.myprofile) {
      container = EditProfile(
          widget.address,
          widget.username,
          widget.contact,
          widget.email,
          widget.image,
          widget.donorId,
          widget.fow,
          widget.desc,
          widget.password);
    } else if (currentPage == DrawerSections.donations) {
      container = DonartionHistory(widget.donorId);
    } else if (currentPage == DrawerSections.settings) {
      container = ChangePassword(widget.donorId, widget.password, widget.email);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0.1,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
          child: Text("E-Donation"),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(widget.email, widget.username, widget.image),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "My Profile", Icons.image,
              currentPage == DrawerSections.myprofile ? true : false),
          menuItem(2, "Donations", Icons.dashboard,
              currentPage == DrawerSections.donations ? true : false),
          Divider(),
          menuItem(3, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(4, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
          logout('Logout', Icons.logout),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.myprofile;
            } else if (id == 2) {
              currentPage = DrawerSections.donations;
            } else if (id == 3) {
              currentPage = DrawerSections.settings;
            } else if (id == 4) {
              currentPage = DrawerSections.notifications;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logout(String title, IconData icon) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  myprofile,
  donations,
  settings,
  notifications,
  notes,
  griddashboard,
}
