import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';

import 'package:form_registration/widgets/custom_bottom_bar.dart';
import '../provider/k2_provider.dart';

// ignore: must_be_immutable
class K2MainScreenWidget extends StatelessWidget {
  K2MainScreenWidget({super.key});

  int index = 0;

  // @override
  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenProvider>();
    index = context.watch<MainScreenProvider>().currentMainScreenIndex;
    return Scaffold(
      backgroundColor: appTheme.gray100,
      body: SizedBox(
          width: SizeUtils.width, //!======= потом поправь
          child: read.mainScreenWidget[index]),
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
