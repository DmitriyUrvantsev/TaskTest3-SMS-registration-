// //import 'package:firebase_2/servises/data_base.dart';
// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:form_registration/data/models/user/userApp.dart';
// import 'package:form_registration/routes/app_routes.dart';
// import 'package:form_registration/servises/data_base.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String? userName;
//   static String verifyId = ""; //!===============

//   // создание нашего UseraApp на данных user FireBase
//   UserApp? _userFromFirebaseUser(User? user) {
//     return user != null ? UserApp(uid: user.uid) : null;
//   }

//   // аутентификация, изменение пользовательского потока(залогинился или нет (user!=null))
//   Stream<UserApp?>? get user {
//     //.map(User? user) => _userFromFirebaseUser(user); - то же самое
//     return _auth.authStateChanges().map(_userFromFirebaseUser);
//   }

//   Future<String>? registerWithPhone(String phoneNumber, BuildContext context) {
//     //final completer = Completer<String>();

//     try {
//       _auth.verifyPhoneNumber(
//         phoneNumber: '+79108273848',
//         //phoneNumber,
//         //timeout: const Duration(seconds: 60),

//         // verificationCompleted: (PhoneAuthCredential credential) async {
//         //   UserCredential authresult =
//         //       await _auth.signInWithCredential(credential);

//         //   User? user = authresult.user;
//         //   _userFromFirebaseUser(user);
//         //   completer.complete("signedUp");
//         // },
//         verificationCompleted: (phoneAuthCredential) async {
//           return;
//         },

//         // verificationFailed: (FirebaseAuthException e) {
//         //   String error = e.code == 'invalid-phone-number'
//         //       ? "Invalid number. Enter again."
//         //       : "Can Not Login Now. Please try again.";
//         //   completer.complete(error);
//         // },
//         verificationFailed: (error) async {
//           return;
//         },

//         // codeSent: (String verificationId, int? resendToken) {
//         //   completer.complete("verified");
//         //   //! Navigator.of(context).pushNamed(AppNavigationRoutes.confirmation);
//         // },
//         codeSent: (verificationId, forceResendingToken) async {
//           verifyId = verificationId;
//           print(verifyId);
//           //Navigator.of(context).pushNamed(AppNavigationRoutes.confirmation);
//           //nextStep();
//         },

//         // codeAutoRetrievalTimeout: (String verificationId) {
//         //   completer.complete("timeout");
//         // },
//         codeAutoRetrievalTimeout: (verificationId) async {
//           return;
//         },
//       );

//       // return completer.future;
//     } on Exception catch (error) {
//       print('error.toString() ${error.toString()}');
//     }
//     return null;
//   }

//   //--------- выйти ---------
//   Future signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (error) {
//       print('error.toString() ${error.toString()}');
//       return null;
//     }
//   }
// }

//import 'package:firebase_2/servises/data_base.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/presentation/f0_auth_screen/screens/k1_confirmation_screen.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userName;
  String? pinCode; //!======
  static String verifyId = ""; //!===============

  UserApp? _userFromFirebaseUser(User? user) {
    return user != null ? UserApp(uid: user.uid) : null;
  }

  // аутентификация, изменение пользовательского потока(залогинился или нет (user!=null))
  Stream<UserApp?>? get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<String>? registerWithPhone(String phoneNumber, BuildContext context) {
    try {
      _auth.verifyPhoneNumber(
        //--------------------------
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        //--------------------------
        // verificationCompleted: (phoneAuthCredential) async {
        //   return;
        // },
        verificationCompleted: (AuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },

        //--------------------------
        // verificationFailed: (error) async {
        //   return;
        // },
        verificationFailed: (FirebaseAuthException e) {
          print('verificationFailed ERROR - $e');
        },

          //--------------------------
        codeSent: (String verificationId, int? forceResendingToken) async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context ) {
                return K1AuthScreenWidget(  verificationId: verificationId);
              });
        },

        // codeAutoRetrievalTimeout: (String verificationId) {
        //   completer.complete("timeout");
        // },
        codeAutoRetrievalTimeout: (verificationId) async {
          //return;
        },
      );

      // return completer.future;
    } on Exception catch (error) {
      print('error.verifyPhoneNumber: ${error.toString()}');
    }
    return null;
  }



///---------------------выйти----------------------------------------
 Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print('error.toString() ${error.toString()}');
      return null;
    }
  }

}
