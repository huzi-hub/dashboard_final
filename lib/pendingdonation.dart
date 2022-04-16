// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import './headingWidget.dart';
import 'package:http/http.dart' as http;
import 'models/donationsModel.dart';

// ignore: must_be_immutable
class PendingDonations extends StatefulWidget {
  final donorId;
  PendingDonations(this.donorId);
  //DonartionHistory(this.donations);
  @override
  _DonartionHistoryState createState() => _DonartionHistoryState();
}

class _DonartionHistoryState extends State<PendingDonations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: const Text(
              'Pending Donations',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Divider(),
          Container(
            height: MediaQuery.of(context).size.height * 0.82,
            margin: const EdgeInsets.only(top: 10),
            child: FutureBuilder(
              future: fetchDonations(http.Client()),
              builder: (context, AsyncSnapshot<List<Donations>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // for (var i = 0; i < index; i++) {
                        return Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          elevation: 1.0,
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                    radius: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        snapshot.data![index].ngoName,
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                title: Text(
                                  snapshot.data![index].name,
                                  style: const TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Text('${snapshot.data![index].date}'),
                                trailing: Column(children: [
                                  const Text('Quantity'),
                                  Text(snapshot.data![index].quantity),
                                ]),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      'Status : ',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    Text(
                                      'Pending',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.red),
                                    )
                                  ]),
                            ],
                          ),
                        );
                        // }
                        // return Text('');
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Donations>> fetchDonations(http.Client client) async {
    const String url =
        'https://edonations.000webhostapp.com/donor_pendingDonations.php';

    var data = {'user_id': widget.donorId};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (result.statusCode == 200) {
      final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
      var parse =
          parsed.map<Donations>((json) => Donations.fromJson(json)).toList();
      return parse;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
