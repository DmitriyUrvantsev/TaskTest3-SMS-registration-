import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k1_confirmation_screen/models/k1_model.dart';
import 'package:form_registration/routes/app_routes.dart';

/// A provider class for the K0Screen.
///
/// This provider manages the state of the K0Screen, including the
/// current k0ModelObj

// ignore_for_file: must_be_immutable
class Screen1Provider extends ChangeNotifier {
  TextEditingController otpController =
      TextEditingController(); //!=============

  K1Model k1ModelObj = K1Model();

  void showMainScreen(context) {
    Navigator.of(context).pushNamed(AppNavigationRoutes.mainScreen);
  }

  void backPop(context) {
    Navigator.of(context).pop();
    notifyListeners();
  }
}
