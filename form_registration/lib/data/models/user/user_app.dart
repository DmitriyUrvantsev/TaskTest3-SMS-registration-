// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class UserApp {
  final String uid;

  UserApp({
    required this.uid,
  });
}

class UserAppData {
  final String uid;
  final String? name;
  final String? surName;
  final String? avatar;
  
  UserAppData({
    required this.uid,
    required this.name,
    this.surName,
    this.avatar,
  });



}
