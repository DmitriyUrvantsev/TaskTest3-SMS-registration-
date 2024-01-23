import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k9_screen/models/k10_model.dart';

/// A provider class for the K10Screen.
///
/// This provider manages the state of the K10Screen, including the
/// current k10ModelObj

// ignore_for_file: must_be_immutable
class Screen9Provider extends ChangeNotifier {
  TextEditingController plusSevenController = TextEditingController();

  K10Model k10ModelObj = K10Model();

  @override
  void dispose() {
    super.dispose();
    plusSevenController.dispose();
  }
}
