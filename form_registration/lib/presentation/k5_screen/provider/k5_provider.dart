import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k5_screen/models/k5_model.dart';

/// A provider class for the K5Page.
///
/// This provider manages the state of the K5Page, including the
/// current k5ModelObj
class Screen5Provider extends ChangeNotifier {
  TextEditingController yourNameController = TextEditingController();

  K5Model k5ModelObj = K5Model();

  @override
  void dispose() {
    super.dispose();
    yourNameController.dispose();
  }
}
