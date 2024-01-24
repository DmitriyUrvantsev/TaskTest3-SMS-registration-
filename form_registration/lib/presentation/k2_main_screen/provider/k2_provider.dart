import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k2_main_screen/models/k2_model.dart';
import 'package:form_registration/presentation/k3_account_screen/k3_account_screen.dart';
import 'package:form_registration/presentation/k4_projects_screen/k4_projects_screen.dart';

class Screen2Provider extends ChangeNotifier {
  K2Model k2ModelObj = K2Model();
  TextEditingController otpController = TextEditingController();
  final List mainScreenWidget = [
    const K4ProjectsScreenWidget(),
    const K3AccounrScreenWidget(),
  ];
  int _currentMainScreenIndex = 0;
  int get currentMainScreenIndex =>   _currentMainScreenIndex;


  void toglleIndex(int index) {
    _currentMainScreenIndex = index;
    notifyListeners();
  }
}
