import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_application_tutorial/domain/firestore_user/firestore_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  int counter = 0;

  Future<void> incrementCounter({required BuildContext context}) async {
    counter++;
    final uuid = Uuid();
    final v4 = uuid.v4();
    final now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
      createdAt: now,
      updatedAt: now,
      userName: "Alice",
      userId: v4,
    );
    final Map<String, dynamic> userData = firestoreUser.toJson();
    // final Map<String, dynamic> userData = {
    //   "userName": "Alice",
    //   "useId": v4,
    // };
    await FirebaseFirestore.instance.collection('user').doc(v4).set(userData);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザーを作成できました！')));
    notifyListeners();
  }
}
