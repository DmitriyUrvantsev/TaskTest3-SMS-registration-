import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

class SelectAvatarWidget extends StatefulWidget {
  const SelectAvatarWidget({super.key});

  @override
  State<SelectAvatarWidget> createState() => _SelectAvatarWidgetState();
}

class _SelectAvatarWidgetState extends State<SelectAvatarWidget> {
  //!===========================================================================
  final imagePicer = ImagePicker();
  File? photo;
//=====================функция загрузки фото===========================
  Future pickImage(ImageSource source) async {
    try {
      final myImage = await imagePicer.pickImage(source: source);
      if (myImage == null) {
        return;
      }
      final imageTemporary = File(myImage.path);

      //final imageTemporary = saveImagePermanently(myImage.path);
      setState(() {
        //!------TEMP-----
        photo = imageTemporary as File;
        //---------------------
        
if (photo != null) {
   final bytes = Uint8List.fromList(photo!.readAsBytesSync());
final imgBase64 = base64Encode(bytes);
print(imgBase64);
}

       




        // print('imageTemporary - $imageTemporary');
        // print('imageTemporary.absolute - ${imageTemporary.absolute}');
        // print('imageTemporary.path - ${imageTemporary.path}');
      });
    } on PlatformException catch (e) {
      print('проблемы с $e');
    }
  }

  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directiry = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directiry.path}/$name');
  //   return File(imagePath).copy(image.path);
  // }

  //!===========================================================================
  //!===========================================================================
  
  @override
  Widget build(BuildContext context) {
    return

//!=============================================================================
//---------------------------ABATARKA-------------------------------------------
//!=============================================================================

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
                  Container(
                    //! иконка svg
                    height: 76.adaptSize,
                    width: 76.adaptSize,

                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: fs.Svg(
                              ImageConstant.imgGroup1,
                            ), //!
                            fit: BoxFit.cover)),
                  ),

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
                  onTap: () => {
                    showImageSource(context)

                    },
                  child: Container(
                    //! иконка svg - кнопка выбора загрузки
                    height: 31.v,
                    width: 31.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: fs.Svg(ImageConstant.imgCloseGray100,
                                color: Colors.black), //!
                            fit: BoxFit.cover)),
                  ),
                ),
              )
            ]));

//!!!++++++++++++++++++++++++++++++++++++++
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
