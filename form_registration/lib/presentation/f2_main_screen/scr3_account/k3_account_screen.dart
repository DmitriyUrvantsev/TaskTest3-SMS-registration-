import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/f2_main_screen/provider/k2_provider.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/appbar_subtitle.dart';
import 'package:form_registration/widgets/app_bar/appbar_title.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

class K3AccounrScreenWidget extends StatefulWidget {
   String uid;
   K3AccounrScreenWidget({super.key, required this.uid});

  @override
  State<K3AccounrScreenWidget> createState() => _K3AccounrScreenWidgetState();
}

class _K3AccounrScreenWidgetState extends State<K3AccounrScreenWidget> {
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // print('user?.uid DID - ${widget.uid}');
    final read = context.read<MainScreenProvider>();
    read.chekChangeUser(widget.uid);
  }
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
        photo = imageTemporary as File;
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
  //=========функция диалога выбора загрузки для  iOS===========================
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

  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenProvider>();
    final watch = context.watch<MainScreenProvider>();
    return Scaffold(
      backgroundColor: appTheme.gray100,
      appBar: _sectionAppBar(context),
      body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 24.v),
          child: Column(children: [
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
                      onTap: () => showImageSource(context),
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
                ])),

//!!!++++++++++++++++++++++++++++++++++++++

            SizedBox(height: 17.v),
            Text('apollo@gmail.com',
                style: CustomTextStyles.labelLargeSFProTextGray600),
            SizedBox(height: 27.v),
            _sectionRowNameSurNameChous(
              context,
              action: 'Имя',
              action1: watch.userName,
              onTapRow: () => read.showFormName(context),
            ),
            SizedBox(height: 5.v),
            _sectionRowNameSurNameChous(
              context,
              action: 'Фамилия',
              action1: watch.userSurName,
              onTapRow: () => read.showFormSurName(context),
            )
          ])),
    );
  }

  /// ======================AppBar==============================================
  PreferredSizeWidget _sectionAppBar(BuildContext context) {
    final read = context.read<MainScreenProvider>();
    return CustomAppBar(
      backgroundColor: PrimaryColors().white, //!=================
      height: 43.v,
      leadingWidth: 28.h,
      leading: AppbarLeadingImage(
          onTap: () => read.backProjectScreen(),
          color: PrimaryColors().lightBlueA700,
          imagePath: ImageConstant.imgArrowRight,
          margin: EdgeInsets.only(left: 8.h, top: 9.v, bottom: 12.v)),
      title: Padding(
          padding: EdgeInsets.only(left: 2.h),
          child: Row(children: [
            AppbarSubtitle(
                onTap: () => read.backProjectScreen(),
                text: 'Мой аккаунт',
                margin: EdgeInsets.only(bottom: 1.v)),
            AppbarTitle(
                onTap: () => (),
                text: 'Аккаунт',
                margin: EdgeInsets.only(left: 26.h))
          ])),
      // styleType: Style.bgShadow,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: PrimaryColors().gray600,
          height: 1.0,
        ),
      ),
    );
  }

  /// Common widget
  Widget _sectionRowNameSurNameChous(
    BuildContext context, {
    required String action,
    required String action1,
    Function? onTapRow,
  }) {
    return GestureDetector(
        onTap: () {
          onTapRow!.call();
        },
        child: Container(
            padding: EdgeInsets.fromLTRB(16.h, 12.v, 16.h, 11.v),
            decoration: AppDecoration.outlineGray,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(action,
                  style: CustomTextStyles.bodyLargeOnPrimary
                      .copyWith(color: theme.colorScheme.onPrimary)),
              const Spacer(),
              Padding(
                  padding: EdgeInsets.only(top: 2.v),
                  child: Text(action1,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: appTheme.gray600))),
              CustomImageView(
                  color: PrimaryColors().gray400,
                  imagePath: ImageConstant.imgArrowRightGray400,
                  height: 21.v,
                  width: 20.h,
                  margin: EdgeInsets.only(left: 10.h))
            ])));
  }
}
