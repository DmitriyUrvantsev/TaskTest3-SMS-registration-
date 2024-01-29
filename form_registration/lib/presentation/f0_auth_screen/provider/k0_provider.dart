import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/servises/auth_servises.dart';
import 'package:form_registration/servises/data_base.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path/path.dart';

class AuthScreenProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService auth = AuthService();
  final formKey = GlobalKey<FormState>();
  String? phone;
  String? error;
  //bool loading = false;

  var maskFormatter = MaskTextInputFormatter(
      mask: '+#(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  Future<void> register(context) async {
    if ((formKey.currentState?.validate() ?? false) && phone != null) {
      //loading = true;
      final phoneNumder = phone!.replaceAll(RegExp(r"[^0-9,+]"), '');
      print('phone - $phoneNumder');
      dynamic result = await auth.registerWithPhone(phoneNumder, context);

      // loading = false; //!------?-----
      /// showSingInPage = true;
      ///
      error = null;
      if (result == null || (phone!.isEmpty)) {
        // loading = false;
        error =
            'Пожалуйста, введите номер телефона'; //! если есть валидация нужно ли мне это здесь????
      }
    }
  }

//!===================Подтверждение===========================================================
  TextEditingController otpController = TextEditingController(); //!======

  UserCredential? credentialUser;
  //User? _user;

  Future confirmation(context, value, verificationId) async {
    String smsCode = value;

    //! Create a PhoneAuthCredential with the code
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      //! Sign the user in (or link) with the credential
      credentialUser = await _auth.signInWithCredential(credential);
      User? _user = credentialUser?.user;

      print('user.uid -${_user?.uid}');

      await DatabaseService(uid: _user!.uid).updateUserData( // );
       'Настоить', 'Настоить' );
      // print('userName - $userName');
      // print('user - $user');

      return _userFromFirebaseUser(_user);
    } on Exception catch (error) {
      print('error.confirmation ${error.toString()}');
      return null;
    }
  }

  // создание нашего UseraApp на данных user FireBase
  UserApp? _userFromFirebaseUser(User? user) {
    return user != null ? UserApp(uid: user.uid) : null;
  }

  // аутентификация, изменение пользовательского потока(реакция на состояние authStateChanges( )
  Stream<UserApp?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  void backPop(context) {
    Navigator.of(context).pop();
    notifyListeners(); //!=====
  }
}