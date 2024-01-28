import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/data/models/user/userApp.dart';
import 'package:form_registration/firebase_options.dart';
import 'package:form_registration/presentation/f0_auth_screen/scr0_auth/provider/k0_provider.dart';
import 'package:form_registration/presentation/f0_auth_screen/scr1_confirmation/provider/k1_provider.dart';
import 'package:form_registration/presentation/f2_main_screen/provider/k2_provider.dart';
import 'package:form_registration/servises/auth_servises.dart';

import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init()
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => Screen0Provider()),
            ChangeNotifierProvider(create: (context) => Screen1Provider()),
            ChangeNotifierProvider(create: (context) => Screen2Provider()),
             StreamProvider<UserApp?>.value(
          value: AuthService().user,
          initialData: null,
        ),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return MaterialApp(
                theme: theme,
                title: 'form_registration',
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,

                initialRoute: MainNavigation().initialRoute,
                routes: MainNavigation().routes,
                //! дизайн не адаптивный(Наименование и заголовки точно)
                //!добавить показ клавы на айфоне!!!!!
                //! клава на регистрации не номер!!!!!!!!!!
                //!клавиатура наезжает на кнопку
                //! повесить функцию на клавиатуру тоже(ВСЕ ЭКРАНЫ)
                //! спроэктоа можно уйти на регистрацию - нужно исправить!!!
                //!изменить клавиатуру на регистрации и на подтверждении тоже!!!
                //! при возврате на 0 стриать тулефон
                //! на странице аккаунта где имя должен быть радиус

                //!onGenerateInitialRoutes: ,
              );
            },
          ),
        );
      },
    );
  }
}

