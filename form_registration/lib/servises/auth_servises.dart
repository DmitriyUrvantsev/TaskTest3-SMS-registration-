//import 'package:firebase_2/servises/data_base.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/data/models/user/userApp.dart';
import 'package:form_registration/routes/app_routes.dart';
import 'package:form_registration/servises/data_base.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userName;

  // создание нашего UseraApp на данных user FireBase
  UserApp? _userFromFirebaseUser(User? user) {
    return user != null ? UserApp(uid: user.uid) : null;
  }

  // аутентификация, изменение пользовательского потока(залогинился или нет (user!=null))
  Stream<UserApp?>? get user {
    //.map(User? user) => _userFromFirebaseUser(user); - то же самое
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // // ---------войти анонимно------------
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;

  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print('ошибка при анонимном входе - ${e.toString()}');
  //     return null;
  //   }
  // }

  // ---------войти с email и password---------
  // Future signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     User? user = result.user;

  //     return user;
  //   } catch (error) {
  //     print('error.toString() ${error.toString()}');
  //     return null;
  //   }
  // }

  // ---------зарегистрироваться с email и password---------
  // Future registerWithEmailAndPassword(
  //     String userFio, String email, String password) async {
  //   userName = userFio;
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User? user = result.user;
  //     await DatabaseService(uid: user!.uid).updateUserData(
  //         '$userName:\n  - чтобы оформить заказ \n - жми "заказ"');
  //     print('userName - $userName');
  //     print('user - $user');
  //     return _userFromFirebaseUser(user);
  //   } catch (error) {
  //     print('error.toString() ${error.toString()}');
  //     return null;
  //   }
  // }

  Future<String>? registerWithPhone(String phoneNumber, BuildContext context) {
    final completer = Completer<String>();

    try {
      _auth.verifyPhoneNumber(
        phoneNumber: '+79108273848',
        //phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential authresult =
              await _auth.signInWithCredential(credential);

          User? user = authresult.user;
          _userFromFirebaseUser(user);
          completer.complete("signedUp");
        },
        verificationFailed: (FirebaseAuthException e) {
          String error = e.code == 'invalid-phone-number'
              ? "Invalid number. Enter again."
              : "Can Not Login Now. Please try again.";
          completer.complete(error);
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete("verified");
          //! Navigator.of(context).pushNamed(AppNavigationRoutes.confirmation);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          completer.complete("timeout");
        },
      );

      return completer.future;
    } on Exception catch (error) {
      print('error.toString() ${error.toString()}');
    }
    return null;
  }

  //--------- выйти ---------
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print('error.toString() ${error.toString()}');
      return null;
    }
  }
}
