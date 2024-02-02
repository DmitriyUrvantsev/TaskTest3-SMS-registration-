import 'package:flutter/material.dart';
import 'package:form_registration/presentation/f2_main_screen/scr3_account/account_form/k7_account_form_name.dart';
import 'package:form_registration/presentation/f2_main_screen/scr3_account/account_form/k7_account_form_surname.dart';
import 'package:form_registration/wrapper.dart';

abstract class AppNavigationRoutes {
  static const selectorLoading = '/'; 
  static const projects = 'main_screen/projects';
  static const account = 'main_screen/account'; 
  static const accountFormName = 'main_screen/account/accountFormName';
  static const accountFormSurName =
      'main_screen/account/accountFormSurname'; 
}

class MainNavigation {
  final initialRoute = AppNavigationRoutes.selectorLoading;

  final routes = <String, Widget Function(BuildContext)>{
    AppNavigationRoutes.selectorLoading: (context) => const SelectorLoading(),
 
    AppNavigationRoutes.accountFormName: (context) =>
        const K7AccountFormNameWidget(),
    AppNavigationRoutes.accountFormSurName: (context) =>
        const K7AccountFormSurNameWidget(),

  };


}
