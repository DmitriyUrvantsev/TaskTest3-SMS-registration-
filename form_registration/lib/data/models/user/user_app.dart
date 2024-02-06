// ignore_for_file: public_member_api_docs, sort_constructors_first

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
 
  
  UserAppData({
    required this.uid,
    required this.name,
    this.surName,
  
  });



}
