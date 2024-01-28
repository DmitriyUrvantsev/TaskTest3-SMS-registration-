import 'package:flutter/material.dart';
import 'package:form_registration/routes/app_routes.dart';
import 'package:form_registration/servises/auth_servises.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path/path.dart';

class Screen0Provider extends ChangeNotifier {
  final AuthService auth = AuthService();
  final formKey = GlobalKey<FormState>();
  String? phone;
  String? error;
  bool loading = false;

  var maskFormatter = MaskTextInputFormatter(
      mask: '+#(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void showScreenConfirmation(context) {
    if (formKey.currentState?.validate() ?? false) {
      register(context);
      //Navigator.of(context).pushNamed(AppNavigationRoutes.confirmation);
    }
  }

  Future<void> register(context) async {
    if ((formKey.currentState?.validate() ?? false) && phone != null) {
      loading = true;
      dynamic result = await auth.registerWithPhone(phone!, context);
      //registerWithEmailAndPassword(userFio, email, password);
      loading = false; //!------?-----
      /// showSingInPage = true;
      error = null;
      if (result == null || (phone!.isEmpty)) {
        loading = false;
        error =
            'Пожалуйста, введите номер телефона'; //! если есть валидация нужно ли мне это здесь????
      }
    }
  }

//!==============================================================================
}
