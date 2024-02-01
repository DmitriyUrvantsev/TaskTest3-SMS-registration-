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
import 'package:flutter_svg/flutter_svg.dart';

class SelectAvatarWidget extends StatefulWidget {
  const SelectAvatarWidget({super.key});

  @override
  State<SelectAvatarWidget> createState() => _SelectAvatarWidgetState();
}

class _SelectAvatarWidgetState extends State<SelectAvatarWidget> {
  // PlatformFile? pickedFile;
  // UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenProvider>();
    return Column(
      children: [
        SizedBox(
            height: 80.adaptSize,
            width: 80.adaptSize,
            child: Stack(children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 2.h, top: 5),
                    height: 70.adaptSize,
                    width: 70.adaptSize,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),

                  //!=========================================================
                  SvgPicture.asset(
                    ImageConstant.imgGroup1,
                    height: 76.adaptSize,
                    width: 76.adaptSize,
                  ),

                  //!---------------Фото----------------------------------

                  AvatarIconWidget()
                ],
              ),

              // ),
              //!=========================================================
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => showImageSource(context, read),
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
  }
}

//!==========================================================================

//!=============================================================================
//---------------------------ABATARKA-------------------------------------------
//!=============================================================================

//                                                                *
//                                                                *
//                                                                *
//              МЕНЮ ВЫБОРА ЗАГРУЗКИ ИЗОБРАЖЕНИЯ                  *
//                                                                *
//                                                                *
//                                                                *
//=========Метод диалога выбора загрузки===========================
Future<ImageSource?> showImageSource(BuildContext context, read) async {
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
                read.pickImage(ImageSource.camera);
                Navigator.of(context).pop(ImageSource.camera);
              },
              child: Text(
                'Камера',
                style: CustomTextStyles.bodyLargeLightblueA700PopUp,
              )),
          CupertinoActionSheetAction(
              onPressed: () {
                read.pickImage(ImageSource.gallery);
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
                    read.pickImage(ImageSource.camera);
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
                    read.pickImage(ImageSource.gallery);
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
              ],
            ));
  }
}

//!===========================================================================

class AvatarIconWidget extends StatefulWidget {
  const AvatarIconWidget({
    super.key,
  });

  @override
  State<AvatarIconWidget> createState() => _AvatarIconWidgetState();
}

class _AvatarIconWidgetState extends State<AvatarIconWidget> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseApi.listAll('files/');
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenProvider>();
    return Stack(
      children: [
        if (read.currentAvatar != null)
          Container(
            height: 76.adaptSize,
            width: 76.adaptSize,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              read.currentAvatar!,
              width: 76,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),
        FutureBuilder<List<FirebaseFile>>(
            future: futureFiles,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.transparent,
                  ));
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text('Some error occurred!'));
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      final files = snapshot.data!;
                      final file = files.first;

                      return Container(
                        height: 76.adaptSize,
                        width: 76.adaptSize,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          read.currentAvatar ?? file.url,
                          width: 76,
                          height: 76,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                  } else {
                    return SizedBox.shrink();
                  }
              }
              return SizedBox.shrink();
            }),
      ],
    );
  }
}
