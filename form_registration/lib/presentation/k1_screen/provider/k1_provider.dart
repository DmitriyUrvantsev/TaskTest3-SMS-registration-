import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k1_screen/models/k1_model.dart';

/// A provider class for the K0Screen.
///
/// This provider manages the state of the K0Screen, including the
/// current k0ModelObj

// ignore_for_file: must_be_immutable
class Screen1Provider extends ChangeNotifier {
  TextEditingController otpController = TextEditingController();

  K1Model k0ModelObj = K1Model();

}
