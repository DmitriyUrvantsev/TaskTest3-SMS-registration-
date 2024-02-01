import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/data/firebase_file/firebase_file.dart';
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
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('files/');
  }

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

      print('name - ${myImage.name}');

      //Future uploadFile() async {
      //const path = 'files/my-image.jpg';
      final path = 'files/${myImage.name!}';
      //final file = File(photo!.path); //конвертация

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(photo!);

      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      print('Download link - $urlDownload');
      //}
    } on PlatformException catch (e) {
      print('проблемы с $e');
    }
  }

  // Future uploadFile() async {
  //   //const path = 'files/my-image.jpg';
  //   final path = 'files/${photo!}';
  //   final file = File(photo!.path); //конвертация

  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   uploadTask = ref.putFile(file);

  //   final snapshot = await uploadTask!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //   print('Download link - $urlDownload');
  // }

//                                                                            *
//                                                                            *
//                                                                            *
//                   ФУНЦИЯ ЗАГРУЗКИ ИЗОБРАЖЕНИЯ                              *
//                                                                            *
//                                                                            *
//                                                                            *
//===================ФУНЦИЯ ЗАГРУЗКИ ИЗОБРАЖЕНИЯ ==============================

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseFile>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: Text('Some error occurred!'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                final files = snapshot.data!;
                final file = files.first;
                return Column(
                  children: [
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

                           
                              //!---------------Фото----------------------------------
                              file != null
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
                                      child:
                                          //========================================
                                          //========================================
                                          // Image.file(photo!,
                                          //     width: 80,
                                          //     height: 80,
                                          //     fit: BoxFit.cover),

                                          Image.network(
                                        file.url,
                                        width: 52,
                                        height: 52,
                                        fit: BoxFit.cover,
                                      ),
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
                              onTap: () => showImageSource(context),
                              child:
                                  //-------
                                  SvgPicture.asset(
                                ImageConstant.imgCloseGray100,
                                width: 31.0,
                                height: 31.0,
                              ),
                              // Container(
                              //   //! иконка svg - кнопка выбора загрузки
                            ),
                          )
                        ])),
                  ],
                );
              } else {
                return const  SizedBox.shrink();
              }

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     buildHeader(files.length),
              //     const SizedBox(height: 12),
              //     Expanded(
              //       child: ListView.builder(
              //         itemCount: files.length,
              //         itemBuilder: (context, index) {
              //           final file = files[index];

              //           return buildFile(context, file);
              //         },
              //       ),
              //     ),
              //   ],
              // );
            } else {
              return const SizedBox.shrink();
            }
        }
      },
    );

//!==========================================================================

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
