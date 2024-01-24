import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/k3_account_screen/k3_account_screen.dart';
import 'package:form_registration/presentation/k4_projects_screen/k4_projects_screen.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_bottom_bar.dart';
import 'provider/k2_provider.dart';

class K2MainScreenWidget extends StatelessWidget {
  const K2MainScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //final read = context.read<Screen2Provider>();//!выдает ошибку/ надо зафигачить мулти в main
    return Scaffold(
      backgroundColor: appTheme.gray100,
      body: SizedBox(
        width: SizeUtils.width, //!======= потом поправь
        child:
            //K3AccounrScreenWidget(),
            K4ProjectsScreenWidget(),
      ),
      bottomNavigationBar: _sectionBottomBar(context),
    );
  }

  /// Section Widget BottomBar =================================================
  Widget _sectionBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
    );
  }
}
