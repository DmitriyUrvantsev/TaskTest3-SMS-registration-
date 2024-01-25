import 'package:flutter/material.dart';
import 'package:form_registration/core/utils/image_constant.dart';
//import 'package:form_registration/presentation/f2_main_screen/models/k2_model.dart';
import 'package:form_registration/presentation/f2_main_screen/scr356_account/k3_account_screen.dart';
import 'package:form_registration/presentation/f2_main_screen/scr4_projects/k4_projects_screen.dart';
import 'package:form_registration/routes/app_routes.dart';
import 'package:form_registration/widgets/custom_bottom_bar.dart';

class Screen2Provider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  //TextEditingController otpController = TextEditingController();
  TextEditingController yourNameController = TextEditingController();
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

//!=======MainScreenModel==================================================
  void toglleIndex(int index) {
    _currentMainScreenIndex = index;
    notifyListeners();
  }

  void backProjectScreen() {
    _currentMainScreenIndex = 0;
    notifyListeners();
  }
//==============================================================================

//!=======AccountScreenModel==================================================
  void showFormName(context) {
    Navigator.of(context).pushNamed(AppNavigationRoutes.accountFormName);
  }
//==============================================================================

//!=======Form Name Model==================================================
  String userName = 'Настроить';

  void backToAccount(context) {
    if (formKey.currentState?.validate() ?? false) {
      userName = yourNameController.text.substring(0, 1).toUpperCase() +
          yourNameController.text.substring(1).toLowerCase();
      print('userName $userName');
      notifyListeners();
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    yourNameController.dispose();
  }
//==============================================================================
}
