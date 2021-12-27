// To parse this JSON data, do
//
//     final donations = donationsFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<Donations> donationsFromJson(String str) =>
    List<Donations>.from(json.decode(str).map((x) => Donations.fromJson(x)));

String donationsToJson(List<Donations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donations {
  Donations({
    required this.ngoName,
    required this.name,
    required this.quantity,
    required this.date,
  });

  String ngoName;
  String name;
  String quantity;
  String date;

  factory Donations.fromJson(Map<String, dynamic> json) => Donations(
        ngoName: json["ngo_name"],
        name: json["name"],
        quantity: json["quantity"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "ngo_name": ngoName,
        "name": name,
        "quantity": quantity,
        "date": date,
      };
}
