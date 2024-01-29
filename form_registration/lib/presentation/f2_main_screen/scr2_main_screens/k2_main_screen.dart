import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/data/models/user_from_firebase/user_from_firebase.dart';
import 'package:form_registration/presentation/f2_main_screen/scr3_account/k3_account_screen.dart';
import 'package:form_registration/presentation/f2_main_screen/scr4_projects/k4_projects_screen.dart';
import 'package:form_registration/servises/data_base.dart';

import 'package:form_registration/widgets/custom_bottom_bar.dart';
import '../provider/k2_provider.dart';

// ignore: must_be_immutable
class K2MainScreenWidget extends StatelessWidget {
  K2MainScreenWidget({super.key});

  int index = 0;

  // @override
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp?>(context);
    final read = context.read<MainScreenProvider>();
    read.uid = user?.uid;
    final List mainScreenWidget = [
      const K4ProjectsScreenWidget(),
      K3AccounrScreenWidget(uid: user?.uid ?? ''),
    ];
    print('K2MainScreenWidget user?.uid - ${user?.uid}');
    index = context.watch<MainScreenProvider>().currentMainScreenIndex;
    return StreamProvider<List<UserFromFirebase>>.value(
        value: DatabaseService(uid: user?.uid ?? 'null').tasks,
        initialData: [UserFromFirebase(name: '')],
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: appTheme.gray100,
            body: SizedBox(
                width: SizeUtils.width, //!======= потом поправь
                child: mainScreenWidget[index]),
            bottomNavigationBar: _sectionBottomBar(context),
          );
        });
  }

  /// Section Widget BottomBar =================================================
  Widget _sectionBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
    );
  }
}
