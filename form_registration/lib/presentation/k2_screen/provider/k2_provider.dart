import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k2_screen/models/k2_model.dart';

/// A provider class for the K2Screen.
///
/// This provider manages the state of the K2Screen, including the
/// current k2ModelObj

// ignore_for_file: must_be_immutable
class Screen2Provider extends ChangeNotifier {
  TextEditingController otpController = TextEditingController();

  K2Model k2ModelObj = K2Model();

}
