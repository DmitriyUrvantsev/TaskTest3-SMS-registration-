// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:form_registration/data/models/user/userApp.dart';
// import 'package:form_registration/firebase_options.dart';
// import 'package:form_registration/presentation/f0_auth_screen/scr0_auth/provider/k0_provider.dart';
// import 'package:form_registration/presentation/f0_auth_screen/scr1_confirmation/provider/k1_provider.dart';
// import 'package:form_registration/presentation/f2_main_screen/provider/k2_provider.dart';
// import 'package:form_registration/servises/auth_servises.dart';

// import 'core/app_export.dart';

// var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//   );
//   Future.wait([
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]),
//     PrefUtils().init()
//   ]).then((value) {
//     runApp(const MyApp());
//   });
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (context) => ThemeProvider()),
//             ChangeNotifierProvider(create: (context) => Screen0Provider()),
//             ChangeNotifierProvider(create: (context) => Screen1Provider()),
//             ChangeNotifierProvider(create: (context) => Screen2Provider()),
//              StreamProvider<UserApp?>.value(
//           value: AuthService().user,
//           initialData: null,
//         ),
//           ],
//           child: Consumer<ThemeProvider>(
//             builder: (context, provider, child) {
//               return MaterialApp(
//                 theme: theme,
//                 title: 'form_registration',
//                 navigatorKey: NavigatorService.navigatorKey,
//                 debugShowCheckedModeBanner: false,

//                 initialRoute: MainNavigation().initialRoute,
//                 routes: MainNavigation().routes,
//                 //! дизайн не адаптивный(Наименование и заголовки точно)
//                 //!добавить показ клавы на айфоне!!!!!
//                 //! клава на регистрации не номер!!!!!!!!!!
//                 //!клавиатура наезжает на кнопку
//                 //! повесить функцию на клавиатуру тоже(ВСЕ ЭКРАНЫ)
//                 //! спроэктоа можно уйти на регистрацию - нужно исправить!!!
//                 //!изменить клавиатуру на регистрации и на подтверждении тоже!!!
//                 //! при возврате на 0 стриать тулефон
//                 //! на странице аккаунта где имя должен быть радиус

//                 //!onGenerateInitialRoutes: ,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

//!============================

import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/test/controllers/auth_service.dart';
import 'package:form_registration/test/pages/home_page.dart';
import 'package:form_registration/test/pages/login_page.dart';
// import 'package:phone_auth_firebase_tutorial/controllers/auth_service.dart';
// import 'package:phone_auth_firebase_tutorial/pages/home_page.dart';
// import 'package:phone_auth_firebase_tutorial/pages/login_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Phone Auth Tutorial',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
        ),
        home: CheckUserLoggedInOrNot());
  }
}

class CheckUserLoggedInOrNot extends StatefulWidget {
  const CheckUserLoggedInOrNot({super.key});

  @override
  State<CheckUserLoggedInOrNot> createState() => _CheckUserLoggedInOrNotState();
}

class _CheckUserLoggedInOrNotState extends State<CheckUserLoggedInOrNot> {
  @override
  void initState() {
    AuthService1.isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
