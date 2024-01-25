import 'package:flutter/material.dart';
import 'package:form_registration/core/utils/image_constant.dart';
import 'package:form_registration/presentation/f2_main_screen/models/k2_model.dart';
import 'package:form_registration/presentation/f2_main_screen/scr356_account/k3_account_screen.dart';
import 'package:form_registration/presentation/f2_main_screen/scr4_projects/k4_projects_screen.dart';
import 'package:form_registration/widgets/custom_bottom_bar.dart';

class Screen2Provider extends ChangeNotifier {
  K2Model k2ModelObj = K2Model();
  TextEditingController otpController = TextEditingController();
  //---------------------------------------------------------------------------
  final List mainScreenWidget = [
    const K4ProjectsScreenWidget(),
    const K3AccounrScreenWidget(),
  ];
  //---------------------------------------------------------------------------
  int _currentMainScreenIndex = 0;
  int get currentMainScreenIndex => _currentMainScreenIndex;

    List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNav,
      activeIcon: ImageConstant.imgNav,
      title: 'Мои проекты',
      type: BottomBarEnum.tf,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavLightBlueA700,
      activeIcon: ImageConstant.imgNavLightBlueA700,
      title: 'Мой аккаунт',
      type: BottomBarEnum.tf,
    )
  ];
//---------------------------------------------------------------------------
  void toglleIndex(int index) {

    _currentMainScreenIndex = index;
    notifyListeners();
  }

  void backProjectScreen() {
    _currentMainScreenIndex = 0;
    notifyListeners();
  }
}
