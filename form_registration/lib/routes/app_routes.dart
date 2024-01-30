import 'package:flutter/material.dart';

import 'package:form_registration/presentation/f2_main_screen/scr3_account/account_form/k7_account_form_name.dart';
import 'package:form_registration/presentation/f2_main_screen/scr3_account/account_form/k7_account_form_surname.dart';
import 'package:form_registration/wrapper.dart';

abstract class AppNavigationRoutes {
  static const selectorLoading = '/'; //k3 + color k0(k9 - дергается)
  //static const confirmation = '/confirmation'; //k1
  //static const mainScreen = 'main_screen'; //k10
  static const projects = 'main_screen/projects'; //k6, k7(photo)
  static const account = 'main_screen/account'; //k6, k7(photo)

  static const accountFormName = 'main_screen/account/accountFormName'; //k5, k8
  static const accountFormSurName =
      'main_screen/account/accountFormSurname'; //k5,k8
}

class MainNavigation {
  final initialRoute = AppNavigationRoutes.selectorLoading;

  final routes = <String, Widget Function(BuildContext)>{
    AppNavigationRoutes.selectorLoading: (context) => const SelectorLoading(),
   
    //AppNavigationRoutes.mainScreen: (context) => K2MainScreenWidget(),
    //AppNavigationRoutes.account: (context) => K2MainScreenWidget(),
    //AppNavigationRoutes.projects: (context) => const K4ProjectsScreenWidget(),

    AppNavigationRoutes.accountFormName: (context) =>
        const K7AccountFormNameWidget(),
    AppNavigationRoutes.accountFormSurName: (context) =>
        const K7AccountFormSurNameWidget(),

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
