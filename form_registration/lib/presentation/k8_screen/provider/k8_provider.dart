import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k8_screen/models/k9_model.dart';

/// A provider class for the K9Screen.
///
/// This provider manages the state of the K9Screen, including the
/// current k9ModelObj
class Screen8Provider extends ChangeNotifier {
  TextEditingController yourLastNameController = TextEditingController();

  K9Model k9ModelObj = K9Model();

  @override
  void dispose() {
    super.dispose();
    yourLastNameController.dispose();
  }
}
