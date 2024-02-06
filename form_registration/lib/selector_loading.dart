import 'package:flutter/material.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/presentation/folder0_auth_screen/screens/k0_auth_screen.dart';
import 'package:form_registration/presentation/folder2_main_screen/main_screen.dart';
import 'package:provider/provider.dart';

class SelectorLoading extends StatelessWidget {
  const SelectorLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp?>(context);
    print('SelectorLoading uid - ${user?.uid} ');

    //в зависимости от того, получен ли ID или нет, попадаем либо на авторизацию
    //либо на главный экран
    if (user?.uid == null) {
      return  K0AuthScreenWidget(uid: user?.uid);
    } else {
      return K2MainScreenWidget(uid: user!.uid);
    }
  }
}
