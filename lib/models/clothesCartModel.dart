// ignore_for_file: file_names

class ClothesModel {
  late String name;
  late String quantity;
  late String note;
  String? clothes_for;
  String? gender;
  String? size;
  String? clothe_type;
  String? time;
  late String date;

  ClothesModel(
      String name,
      String quantity,
      String note,
      String clothes_for,
      String gender,
      String size,
      String clothe_type,
      String time,
      String date) {
    this.name = name;
    this.quantity = quantity;
    this.note = note;
    this.clothes_for = clothes_for;
    this.gender = gender;
    this.size = size;
    this.clothe_type = clothe_type;
    this.time = time;
    this.date = date;
  }
}
