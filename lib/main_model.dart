import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_application_tutorial/domain/firestore_user/firestore_user.dart';

final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  int counter = 0;

  Future<void> incrementCounter({required BuildContext context}) async {
    counter++;
    final uuid = Uuid();
    final v4 = uuid.v4();
    final FirestoreUser firestoreUser =
        FirestoreUser(userName: "Alice", userId: v4);
    final Map<String, dynamic> userData = firestoreUser.toJson();
    final Map<String, dynamic> userData2 = {
      "userId": "abcd",
      "userName": "BOb",
    };
    print(userData["userId"]);
    final FirestoreUser firestoreUser2 = FirestoreUser.fromJson(userData2);
    // final Map<String, dynamic> userData = {
    //   "userName": "Alice",
    //   "useId": v4,
    // };
    print(firestoreUser2.userName);
    await FirebaseFirestore.instance.collection('user').doc(v4).set(userData);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザーを作成できました！')));
    notifyListeners();
  }
}
