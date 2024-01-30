import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/data/models/user_from_firebase/user_from_firebase.dart';

class DatabaseService extends ChangeNotifier {
  final String uid;
  DatabaseService({required this.uid});



  // ---------ссылка на коллекцию ---------
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('form_registration');


  Future<void> updateUserData(
      [String? name, String? surName, String? avatar]) async {
    Map<String, dynamic> data = {
      'name': name,
      'surName': surName,
      'avatar': avatar,
    };
    return await taskCollection.doc(uid).set(data);
  }

  // ---------userFromFireBase list from snapshot ---------
  List<UserFromFirebase> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserFromFirebase(
        name: doc.get('name') ?? '0',
        surName: doc.get('surName') ?? '0',
        avatar: doc.get('avatar') ?? '0',
      );
    }).toList();
  }

// ---------user data from snapshots ---------
  UserAppData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserAppData(
      uid: uid,
      name: snapshot.get('name'),
      surName: snapshot.get('surName'),
      avatar: snapshot.get('avatar'),
    );
  }

  // ---------получение tasks stream ---------
  Stream<List<UserFromFirebase>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }

  // --------- получение user doc stream ---------
  Stream<UserAppData> get userData {
    return taskCollection
        .doc(uid)
        .snapshots()
        .map((e) => _userDataFromSnapshot(e));
  }
}
