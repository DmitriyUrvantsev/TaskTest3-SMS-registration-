import 'package:flutter/material.dart';
import 'package:form_registration/routes/app_routes.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Screen0Provider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(
      mask: '+#(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void showScreenConfirmation(context) {
    print(formKey.currentState);
   if (formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushNamed(AppNavigationRoutes.confirmation);
    }
  }

//!==============================================================================

}
