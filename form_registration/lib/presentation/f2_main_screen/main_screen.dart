import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/presentation/f2_main_screen/provider/maim_screen_provider.dart';
import 'package:form_registration/presentation/f2_main_screen/scr3_account/k3_account_screen.dart';
import 'package:form_registration/presentation/f2_main_screen/scr4_projects/k4_projects_screen.dart';
import 'package:form_registration/servises/data_base.dart';
import 'package:form_registration/widgets/custom_bottom_bar.dart';

class K2MainScreenWidget extends StatefulWidget {
  final String uid;

  const K2MainScreenWidget({super.key, required this.uid});

  @override
  State<K2MainScreenWidget> createState() => _K2MainScreenWidgetState();
}

class _K2MainScreenWidgetState extends State<K2MainScreenWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // print('user?.uid DID - ${widget.uid}');
    final read = context.read<MainScreenProvider>();
    //!read.chekChangeUser(widget.uid);
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    UserApp user = Provider.of<UserApp>(context);
    final read = context.read<MainScreenProvider>();

    read.uid = user.uid;
    final List mainScreenWidget = [
      const K4ProjectsScreenWidget(),
      K3AccounrScreenWidget(uid: user.uid ?? ''),
    ];
    print('K2MainScreenWidget user?.uid - ${user.uid}');
    index = context.watch<MainScreenProvider>().currentMainScreenIndex;

    return StreamBuilder<UserAppData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserAppData? userData = snapshot.data;
            read.snapShot = snapshot;
            // read.cleanerUserName(
            //     userData); //!сомнения конечно//такто можно сделать лучше

            return Scaffold(
              backgroundColor: appTheme.gray100,
              body: SizedBox(
                  width: SizeUtils.width, //!======= потом поправь
                  child: mainScreenWidget[index]),
              bottomNavigationBar: _sectionBottomBar(context),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _sectionBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
    );
  }
}
