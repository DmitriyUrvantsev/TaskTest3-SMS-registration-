import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k0_auth_screen/models/k0_model.dart';

/// A provider class for the K3Screen.
///
/// This provider manages the state of the K3Screen, including the
/// current k3ModelObj

// ignore_for_file: must_be_immutable
class Screen0Provider extends ChangeNotifier {
  TextEditingController phoneValueController = TextEditingController();

  K0Model k3ModelObj = K0Model();

  @override
  void dispose() {
    super.dispose();
    phoneValueController.dispose();
  }
}
