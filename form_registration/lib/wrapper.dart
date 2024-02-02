import 'package:flutter/material.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/presentation/f0_auth_screen/screens/k0_auth_screen.dart';
import 'package:form_registration/presentation/f0_auth_screen/screens/k1_confirmation_screen.dart';
import 'package:form_registration/presentation/f2_main_screen/main_screen.dart';
import 'package:provider/provider.dart';

class SelectorLoading extends StatelessWidget {
  const SelectorLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp?>(context);
  
    if (user?.uid == null) {
      return const K1AuthScreenWidget();
    } else {
      return K2MainScreenWidget(uid: user!.uid);
    }
  }
}
