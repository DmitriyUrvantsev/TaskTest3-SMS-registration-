import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/routes/app_routes.dart';
import 'package:form_registration/servises/auth_servises.dart';
import 'package:form_registration/servises/data_base.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthScreenProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService auth = AuthService();
  final formKey = GlobalKey<FormState>();
  String? phone;
  String? error;
  bool isPossibleRegistr = false;
  bool? isPossibleSentCode = false;

  var maskFormatter = MaskTextInputFormatter(
      mask: '+#(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  Future<void> register(context, String? uid) async {
    if ((formKey.currentState?.validate() ?? false) && phone != null) {
      final phoneNumder = phone!.replaceAll(RegExp(r"[^0-9,+]"), '');
      dynamic result = await auth.registerWithPhone(phoneNumder, context, uid);

      error = null;
      if (result == null || (phone!.isEmpty)) {
        error = 'Пожалуйста, введите номер телефона';
      }
    }
  }

  void onCangeTextField(p0) {
    phone = p0;
    p0.length < 17 ? isPossibleRegistr = false : isPossibleRegistr = true;
    print(isPossibleRegistr);
    notifyListeners();
  }

//!===================Подтверждение=============================================
  TextEditingController otpController = TextEditingController();

  UserCredential? credentialUser;

  Future confirmation(context, value, verificationId, String? uid) async {
    String smsCode = value;
    if (uid == null) {//если нет регистрации, то обновляем DatabaseService
      //! Create a PhoneAuthCredential with the code
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        //! Sign the user in (or link) with the credential
        credentialUser = await _auth.signInWithCredential(credential);
        User? user = credentialUser?.user;

        await DatabaseService(uid: user!.uid)
            .updateUserData('Настоить', 'Настоить');

        Navigator.of(context)
            .pushReplacementNamed(AppNavigationRoutes.selectorLoading);

        return _userFromFirebaseUser(user);
      } on Exception catch (error) {
        print(error);
        return null;
      }
    } else {//если есть регистрация, то не обновляем DatabaseService
      //! Create a PhoneAuthCredential with the code
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        //! Sign the user in (or link) with the credential
        credentialUser = await _auth.signInWithCredential(credential);
        User? user = credentialUser?.user;

        Navigator.of(context)
            .pushReplacementNamed(AppNavigationRoutes.selectorLoading);

        return _userFromFirebaseUser(user);
      } on Exception catch (error) {
        print(error);
        return null;
      }
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

  //!====================Таймер=================================================
  Timer? _timer;
  int? start;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (start != null) {
        if (start! < 1) {
          timer.cancel();
          isPossibleSentCode = true;
          notifyListeners();
        } else {
          start = start! - 1;
          notifyListeners();
        }
      }
    });

    notifyListeners();
  }

  void backPop(context) {
    Navigator.of(context).pop();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
