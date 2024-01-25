import 'package:flutter/material.dart';

import 'package:form_registration/presentation/f0_auth_screen/scr1_confirmation/k1_confirmation_screen.dart';
import 'package:form_registration/presentation/f0_auth_screen/scr0_auth/screens/k0_auth_screen.dart';
import 'package:form_registration/presentation/f2_main_screen/scr2_main_screens/k2_main_screen.dart';
import 'package:form_registration/presentation/f2_main_screen/scr356_account/k3_account_screen.dart';
import 'package:form_registration/presentation/f2_main_screen/scr4_projects/k4_projects_screen.dart';




abstract class AppNavigationRoutes {
  static const auth = '/'; //k3 + color k0(k9 - дергается)
  static const confirmation = '/confirmation'; //k1
  static const mainScreen = 'main_screen'; //k10
  static const projects = 'main_screen/projects'; //k6, k7(photo)
  static const account = 'main_screen/account'; //k6, k7(photo)

  static const accountFormName = 'main_screen/account/accountFormName'; //k5, k8
  static const accountFormSurname =
      'main_screen/account/accountFormSurname'; //k5,k8
}

class MainNavigation {
  final initialRoute = AppNavigationRoutes.auth;

  final routes = <String, Widget Function(BuildContext)>{
    AppNavigationRoutes.auth: (context) =>const K0AuthScreenWidget(),
       AppNavigationRoutes.confirmation: (context) => const K1AuthScreenWidget(),
     AppNavigationRoutes.mainScreen: (context) =>  K2MainScreenWidget(),
    AppNavigationRoutes.account: (context) => const K3AccounrScreenWidget(),
   
    AppNavigationRoutes.projects: (context) => const K4ProjectsScreenWidget(),


//!--------------------
    // AppNavigationRoutes.accountFormSurname: (context) => ChangeNotifierProvider(
    //     create: (context) => Screen0Provider(),
    //     child: const K0AuthScreenWidget()),
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
