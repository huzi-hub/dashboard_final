// ignore_for_file: file_names

class ProductModel {
  late String donation;
  late String quantity;
  late String note;
  late String _mySelection;
  late String ngoname;
  late String _time;

  ProductModel(String donation, String quantity, String note,
      String _mySelection, String ngoname, String _time) {
    this.donation = donation;
    this.quantity = quantity;
    this.note = note;
    this._mySelection = _mySelection;
    this.ngoname = ngoname;
    this._time = _time;
  }
}
