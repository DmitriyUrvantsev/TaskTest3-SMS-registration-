import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/firebase_options.dart';
import 'package:form_registration/presentation/f0_auth_screen/provider/k0_provider.dart';
import 'package:form_registration/presentation/f2_main_screen/provider/maim_screen_provider.dart';
import 'package:form_registration/servises/auth_servises.dart';

import 'core/app_export.dart';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/f2_main_screen/provider/maim_screen_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (context) => ThemeProvider()),
//             ChangeNotifierProvider(create: (context) => AuthScreenProvider()),
//             ChangeNotifierProvider(create: (context) => MainScreenProvider()),
//             StreamProvider<UserApp?>.value(
//               value: AuthService().user,
//               initialData: null,
//             ),
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
//                 //!майн не открывается сразу после авторизации!!!!!!!!
//                 //! дизайн не адаптивный(Наименование и заголовки точно)
//                 //!добавить показ клавы на айфоне!!!!!
//                 //! клава на регистрации не номер!!!!!!!!!!
//                 //!клавиатура наезжает на кнопку
//                 //! повесить функцию на клавиатуру тоже(ВСЕ ЭКРАНЫ)
//                 //! спроэктоа можно уйти на регистрацию - нужно исправить!!!
//                 //!изменить клавиатуру на регистрации и на подтверждении тоже!!!
//                 //! при возврате на 0 стриать тулефон
//                 //! на странице аккаунта где имя должен быть радиус
//                 //! задиспоитить контроллеры
//                 //!фото слетает!!!!!

//                 //!onGenerateInitialRoutes: ,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }





class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/files').listAll();
    //  final futureFiles = FirebaseStorage.instance
    //     .ref('gs://smsregistration.appspot.com/files')
    //     .listAll();

   

  }

  @override
  Widget build(BuildContext context) {
    //futureFiles = FirebaseStorage.instance.ref('/files').listAll();
    return MaterialApp(
      home: Scaffold(
          body: FutureBuilder<ListResult>(
              future: futureFiles,
              builder:
                  (BuildContext context, AsyncSnapshot<ListResult> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container(
                        child: Center(child: Text('No Connection Message')));

                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Container(
                        child: Center(child: Text('Loading_message..')));
                  case ConnectionState.done:
                    if (snapshot.data!.items.isEmpty) {
                      return Container(
                          child: Center(child: Text('No Data available')));
                    } else {
                      final files = snapshot.data!.items;
                      return ListView.builder(
                          itemCount: snapshot.data!.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final file = files[index];
                            return ListTile(
                              title: Text(file.name, softWrap: true),
                              onTap: () {},
                            );
                          });
                    }
                }
                // return null;
              })

          //  FutureBuilder<ListResult>(
          //     future: futureFiles,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         final files = snapshot.data!.items;
          //         return SizedBox(
          //           height: 700,
          //           child: ListView.builder(
          //             itemCount: files.length,
          //             itemBuilder: (context, index) {
          //               final file = files[index];
          //               return ListTile(
          //                   title: Text(
          //                     file.name,
          //                     style: const TextStyle(color: Colors.black),
          //                   ),
          //                   trailing: IconButton(
          //                     onPressed: () => downloadFile(file),
          //                     icon: const Icon(
          //                       Icons.download_done_outlined,
          //                       color: Color.fromARGB(255, 255, 2, 2),
          //                     ),
          //                   ));
          //             },
          //           ),
          //         );
          //       } else if (snapshot.hasData) {
          //         return Text('error');
          //       } else {
          //         return const Center(child: CircularProgressIndicator());
          //       }
          //     }),

          ),
    );
  }

  Future downloadFile(Reference ref) async {
//альтернативно можно так:(user не видит путь)??
    //! final url = await ref.getDownloadURL();
    //! final tempDir = await getTemporaryDirectory();
    //! final path = '${tempDir.path}/${ref.name}';
    //! await Dio().download(url, path);

    //! //-------------
    //! if (url.contains('.mp4')) {
    //!   GallerySaver.saveVideo(path, toDcim: true);
    //! } else {
    //!   GallerySaver.saveImage(path, toDcim: true);
    //! }

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Downloaded ${ref.name}')));
  }
}
