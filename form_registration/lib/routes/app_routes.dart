import 'package:flutter/material.dart';
import 'package:form_registration/presentation/k10_screen/k10_screen.dart';
import 'package:form_registration/presentation/k10_screen/provider/k10_provider.dart';
import 'package:form_registration/presentation/k1_screen/k1_screen.dart';
import 'package:form_registration/presentation/k1_screen/provider/k1_provider.dart';
import 'package:form_registration/presentation/k0_auth_screen/provider/k0_provider.dart';
import 'package:form_registration/presentation/k2_screen/k2_screen.dart';
import 'package:form_registration/presentation/k2_screen/provider/k2_provider.dart';
import 'package:form_registration/presentation/k0_auth_screen/screens/k0_screen.dart';
import 'package:form_registration/presentation/k0_auth_screen/provider/k0_provider.dart';
import 'package:form_registration/presentation/k4_screen/k4_screen.dart';
import 'package:form_registration/presentation/k4_screen/provider/k4_provider.dart';
import 'package:form_registration/presentation/k5_screen/k5_page.dart';
import 'package:form_registration/presentation/k5_screen/provider/k5_provider.dart';
import 'package:form_registration/presentation/k6_screen/k6_screen.dart';
import 'package:form_registration/presentation/k6_screen/provider/k6_provider.dart';
import 'package:form_registration/presentation/k7_screen/k7_screen.dart';
import 'package:form_registration/presentation/k7_screen/provider/k7_provider.dart';
import 'package:form_registration/presentation/k8_screen/k8_screen.dart';
import 'package:form_registration/presentation/k8_screen/provider/k8_provider.dart';
import 'package:form_registration/presentation/k9_screen/k9_screen.dart';
import 'package:form_registration/presentation/k9_screen/provider/k9_provider.dart';

import 'package:provider/provider.dart';

abstract class AppNavigationRoutes {
  static const auth = '/'; //k3 + color k0(k9 - дергается)
  static const confirmation = '/confirmation'; //k1
  static const mainScreen = 'main_screen'; //k10
  static const account = 'main_screen/account'; //k6, k7(photo)
  static const accountFormName = 'main_screen/account/accountFormName'; //k5, k8
  static const accountFormSurname =
      'main_screen/account/accountFormSurname'; //k5,k8
}

class MainNavigation {
  final initialRoute = AppNavigationRoutes.auth;

  final routes = <String, Widget Function(BuildContext)>{
    AppNavigationRoutes.auth: (context) => ChangeNotifierProvider(
        create: (context) => Screen0Provider(), child: const K0AuthScreenWidget()),
//! - auth k3, цвет дисейлконпки в к0

    //--------------------
    AppNavigationRoutes.confirmation: (context) => ChangeNotifierProvider(
        create: (context) => Screen1Provider(), child: const K1ScreenWidget()),
//! - confirmation k1
    //--------------------
    AppNavigationRoutes.account: (context) => ChangeNotifierProvider(
        create: (context) => Screen0Provider(), child: const K2ScreenWidget()),
//--------------------
    AppNavigationRoutes.accountFormName: (context) => ChangeNotifierProvider(
        create: (context) => Screen0Provider(), child: const K0AuthScreenWidget()),
//--------------------
    AppNavigationRoutes.accountFormSurname: (context) => ChangeNotifierProvider(
        create: (context) => Screen0Provider(), child: const K0AuthScreenWidget()),
  };

// //----------------наша функция где можно передать arg ---------------------------------
//   Route<Object> onGenerateRoutes(RouteSettings settings) {
//     //! в main добавить!!!!!!!!!!
//     switch (settings.name) {
//       case AppNavigationRoutes.apartmentScreen:
//         final nameHotel = settings.arguments as String;
//         return MaterialPageRoute(
//             builder: (context) => ChangeNotifierProvider(
//               create: (context) => Screen1Provider(),
//               child: ApartmentScreen(
//                     nameHotel: nameHotel,
//                   ),
//             ));
//       //----------------//
//       case AppNavigationRoutes.reservationScreen:
//         final arguments = settings.arguments;
//         final apartmentID = arguments is int ? arguments : 0;
//         return MaterialPageRoute(
//             builder: (context) => ChangeNotifierProvider(
//                create: (context) => Screen2Provider(),
//               child: ReservationScreen(
//                     apartmentID: apartmentID,
//                   ),
//             ));
//  //----------------//
//             case AppNavigationRoutes.paidScreen:
//         final arguments = settings.arguments;
//         final apartmentID = arguments is int ? arguments : 0;
//         return MaterialPageRoute(
//             builder: (context) => ChangeNotifierProvider(
//               create: (context) => Screen3Provider(),
//               child: PaidScreen(
//                     apartmentID: apartmentID,
//                   ),
//             ));
//       default:
//         const widget = Text('Navigation Error');
//         return MaterialPageRoute(builder: (context) => widget);
//     }
//   }
}
