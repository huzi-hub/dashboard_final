// ignore_for_file: file_names

class ProductModel {
  late String name;
  late String quantity;
  late String note;
  String? mySelection;
  // late String ngoname;
  String? time;
  late String date;

  ProductModel(String name, String quantity, String note, String mySelection,
      String time, String date) {
    this.name = name;
    this.quantity = quantity;
    this.note = note;
    this.mySelection = mySelection;
    // this.ngoname = ngoname;
    this.time = time;
    this.date = date;
  }
}
