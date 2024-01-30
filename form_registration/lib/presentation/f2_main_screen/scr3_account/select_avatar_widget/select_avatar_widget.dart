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
//import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:path_provider/path_provider.dart';
//import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectAvatarWidget extends StatefulWidget {
  const SelectAvatarWidget({super.key});

  @override
  State<SelectAvatarWidget> createState() => _SelectAvatarWidgetState();
}

class _SelectAvatarWidgetState extends State<SelectAvatarWidget> {
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/files').listAll();
  }

  //!=======================старый код====================================================
  final imagePicer = ImagePicker();
  File? photo;
 // PlatformFile? myImage;
//=====================функция загрузки фото===========================
  Future pickImage(ImageSource source) async {
    final read = context.read<MainScreenProvider>();
    try {
      final myImage = await imagePicer.pickImage(source: source);
      if (myImage == null) {
        return;
      }
      final imageTemporary = File(myImage.path);

      setState(() {
        photo = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('проблемы с $e');
    }
  }

  Future uploadFile() async {
    //const path = 'files/my-image.jpg';
    final path = 'files/${photo!}';
    final file = File(photo!.path); //конвертация

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download link - $urlDownload');
  }

//                                                                            *
//                                                                            *
//                                                                            *
//                   ФУНЦИЯ ЗАГРУЗКИ ИЗОБРАЖЕНИЯ                              *
//                                                                            *
//                                                                            *
//                                                                            *
//===================ФУНЦИЯ ЗАГРУЗКИ ИЗОБРАЖЕНИЯ ==============================

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

//------------------------------------------------------------------------------
//final result = await FilePicker.
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  // Future uploadFile() async {
  //   final path = 'files/${pickedFile!.name}';
  //   final file = File(pickedFile!.path!);
  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   ref.putFile(file);
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListResult>(
      future: futureFiles,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final newFiles = snapshot.data!.items;

          return Column(
            children: [
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: newFiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    final file = newFiles[index];

                    return ListTile(
                        title: Text(file.name),
                        trailing: IconButton(
                          onPressed: () => downloadFile(file),
                          icon: const Icon(
                            Icons.download_done_outlined,
                            color: Colors.grey,
                          ),
                        ));
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () => downloadFile, child: Text('dsгрузить')),
              SizedBox(
                  height: 95.adaptSize,
                  width: 95.adaptSize,
                  child: Stack(alignment: Alignment.center, children: [
                    Stack(
                      children: [
                        CustomImageView(
                            //! синяя подложка под svg
                            imagePath: ImageConstant.imgClose,
                            color: PrimaryColors().lightBlueA700, //!
                            height: 70.adaptSize,
                            width: 70.adaptSize,
                            // alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 3.h, top: 5)),

                        //!=========================================================
                        SvgPicture.asset(
                          ImageConstant.imgGroup1,
                          height: 76.adaptSize,
                          width: 76.adaptSize,
                        ),

                        // Container(
                        //   //! иконка svg
                        //   height: 76.adaptSize,
                        //   width: 76.adaptSize,

                        //   decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //           image: fs.Svg(
                        //             ImageConstant.imgGroup1,
                        //           ), //!
                        //           fit: BoxFit.cover)),
                        // ),

                        //!---------------Фото----------------------------------
                        photo != null
                            ?
                            //
                            //
                            Container(
                                height: 76.adaptSize,
                                width: 76.adaptSize,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.file(photo!,
                                    width: 80, height: 80, fit: BoxFit.cover),
                              )

                            //
                            //
                            : const SizedBox.shrink(),
                      ],
                    ),

                    // ),
                    //!=========================================================
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => {}, //! showImageSource(context),
                        child:
                            //-------
                            SvgPicture.asset(
                          ImageConstant.imgCloseGray100,
                          width: 31.0,
                          height: 31.0,
                        ),
                        // Container(
                        //   //! иконка svg - кнопка выбора загрузки
                        //   height: 31.v,
                        //   width: 31.h,
                        //   decoration: BoxDecoration(
                        //       image:
                        //       // DecorationImage(
                        //       //     image:

                        //       //     // fs.Svg(ImageConstant.imgCloseGray100,
                        //       //     //     color: Colors.black), //!
                        //       //     fit: BoxFit.cover)
                        //           ),
                        // ),
                      ),
                    )
                  ])),
            ],
          );
        } else if (snapshot.hasError) {
          return const Text('Error occured');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );

//!=============================================================================
//---------------------------ABATARKA-------------------------------------------
//!=============================================================================
  }

//                                                                *
//                                                                *
//                                                                *
//              МЕНЮ ВЫБОРА ЗАГРУЗКИ ИЗОБРАЖЕНИЯ                  *
//                                                                *
//                                                                *
//                                                                *
//=========Метод диалога выбора загрузки===========================
  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          message: Text(
            'Выберете фото',
            style: CustomTextStyles.bodyLargeLightblueA700.copyWith(
              color: appTheme.gray600,
            ),
          ),
          cancelButton: TextButton(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
            child: Text(
              'Закрыть',
              style: CustomTextStyles.bodyLargeLightblueA700PopUpBold,
            ),
          ), //!
          actions: [
            CupertinoActionSheetAction(
                onPressed: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop(ImageSource.camera);
                },
                child: Text(
                  'Камера',
                  style: CustomTextStyles.bodyLargeLightblueA700PopUp,
                )),
            CupertinoActionSheetAction(
                onPressed: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop(ImageSource.gallery);
                },
                child: Text(
                  'Галерея Фото',
                  style: CustomTextStyles.bodyLargeLightblueA700PopUp,
                )),
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt_outlined,
                        color: PrimaryColors().lightBlueA700),
                    title: Text(
                      'Камерa',
                      style: CustomTextStyles.bodyLargeLightblueA700.copyWith(
                        color: appTheme.lightBlueA700,
                      ),
                    ),
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.of(context).pop(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.image, color: PrimaryColors().lightBlueA700),
                    title: Text(
                      'Галерея',
                      style: CustomTextStyles.bodyLargeLightblueA700.copyWith(
                        color: appTheme.lightBlueA700,
                      ),
                    ),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.of(context).pop(ImageSource.gallery);
                    },
                  ),
                ],
              ));
    }
  }

  //!===========================================================================
}

// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:form_registration/core/app_export.dart';
// import 'package:form_registration/presentation/f2_main_screen/provider/maim_screen_provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class SelectAvatarWidget extends StatefulWidget {
//   const SelectAvatarWidget({super.key});

//   @override
//   State<SelectAvatarWidget> createState() => _SelectAvatarWidgetState();
// }

// class _SelectAvatarWidgetState extends State<SelectAvatarWidget> {
//   late Future<ListResult> futureFiles;

//   @override
//   void initState() {
//     super.initState();
//     futureFiles = FirebaseStorage.instance.ref('/files').listAll();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: futureFiles,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final files = snapshot.data!.items;
//             return SizedBox(
//               height: 400,
//               child: ListView.builder(
//                 itemCount: files.length,
//                 itemBuilder: (context, index) {
//                   final file = files[index];
//                   return ListTile(
//                       title: Text(file.name),
//                       trailing: IconButton(
//                         onPressed: () => downloadFile(file),
//                         icon: const Icon(
//                           Icons.download_done_outlined,
//                           color: Colors.grey,
//                         ),
//                       ));
//                 },
//               ),
//             );
//           } else if (snapshot.hasData) {
//             return Text('error');
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         });
//   }

//   Future downloadFile(Reference ref) async {
// //альтернативно можно так:(user не видит путь)??
//     //! final url = await ref.getDownloadURL();
//     //! final tempDir = await getTemporaryDirectory();
//     //! final path = '${tempDir.path}/${ref.name}';
//     //! await Dio().download(url, path);

//     //! //-------------
//     //! if (url.contains('.mp4')) {
//     //!   GallerySaver.saveVideo(path, toDcim: true);
//     //! } else {
//     //!   GallerySaver.saveImage(path, toDcim: true);
//     //! }

//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/${ref.name}');

//     await ref.writeToFile(file);
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text('Downloaded ${ref.name}')));
//   }
// }
