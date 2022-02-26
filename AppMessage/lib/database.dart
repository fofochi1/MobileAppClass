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
      'role': 'customer',
      'uid': uid,
    });
  }
}

class SendPost{
     DateTime currentTime = new DateTime.now();

     final String uid;
     SendPost({ required this.uid });
     final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

     Future updatePost(String text) async {
       return await posts.add({
         'user': uid,
         'post': text,
         'date': currentTime,
       });
     }

}

class sendMessage{
    DateTime currentTime = new DateTime.now();
    final String uid;
     sendMessage({ required this.uid });
     final CollectionReference messages = FirebaseFirestore.instance.collection('messages');

     Future updatePost(String content, String idFrom, String idTo) async {
       return await messages.add({
         'content': content,
         'idFrom': idFrom,
         'idTo': idTo,
         'timestamp': currentTime,
       });
     }
}

class sendRating{
  final CollectionReference ratings = FirebaseFirestore.instance.collection('ratings');

  Future updateRatings(int review, String user, String userID) async {
    return await ratings.add({
      'review': review,
      'user': user,
      'userID': userID,
    });
  }
}