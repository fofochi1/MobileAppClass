// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';

class DatabaseService {
   DateTime currentTime = new DateTime.now();

 
  final String uid;
  DatabaseService({ required this.uid });
  final CollectionReference userInfo = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String username, String firstname, String lastname) async {
    return await userInfo.doc(uid).set({
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'registration': currentTime,
    });
  }
}