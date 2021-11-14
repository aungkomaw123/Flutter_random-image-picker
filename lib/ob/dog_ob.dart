class DogOb {
  String message;
  String status;

  DogOb.fromMap(Map<String, dynamic> map) {
    message = map['message'];
    status = map['status'];
  }
}
