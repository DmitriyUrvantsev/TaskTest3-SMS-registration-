import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/presentation/f0_auth_screen/scr0_auth/provider/k0_provider.dart';
import 'package:form_registration/presentation/f0_auth_screen/scr1_confirmation/provider/k1_provider.dart';
import 'package:form_registration/presentation/f2_main_screen/provider/k2_provider.dart';


import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
                //!добавить показ клавы на айфоне!!!!!
                //!клавиатура наезжает на кнопку
                //! повесить функцию на клавиатуру тоже
                //!изменить клавиатуру на регистрации и на подтверждении тоже!!!
                //! при возврате на 0 стриать тулефон

                //!onGenerateInitialRoutes: ,
              );
            },
          ),
        );
      },
    );
  }
}
