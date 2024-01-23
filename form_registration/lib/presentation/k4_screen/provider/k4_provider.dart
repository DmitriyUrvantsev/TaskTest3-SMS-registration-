import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k4_screen/models/k4_model.dart';

/// A provider class for the K4Screen.
///
/// This provider manages the state of the K4Screen, including the
/// current k4ModelObj
class Screen4Provider extends ChangeNotifier {
  TextEditingController otpController = TextEditingController();

  K4Model k4ModelObj = K4Model();

}
