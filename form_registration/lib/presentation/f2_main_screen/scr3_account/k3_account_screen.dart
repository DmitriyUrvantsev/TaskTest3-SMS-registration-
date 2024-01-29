import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/data/models/user/user_app.dart';
import 'package:form_registration/data/models/user_from_firebase/user_from_firebase.dart';
import 'package:form_registration/presentation/f2_main_screen/provider/maim_screen_provider.dart';
import 'package:form_registration/presentation/f2_main_screen/scr3_account/select_avatar_widget/select_avatar_widget.dart';
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
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // print('user?.uid DID - ${widget.uid}');
  //   final read = context.read<MainScreenProvider>();
  //   //!read.chekChangeUser(widget.uid);
  // }


  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenProvider>();
   // final watch = context.watch<MainScreenProvider>();
    return Scaffold(
      backgroundColor: appTheme.gray100,
      appBar: _sectionAppBar(context),
      body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 24.v),
          child: Column(children: [

            //----------------------------------------
            const SelectAvatarWidget(),

            SizedBox(height: 17.v),
            Text('apollo@gmail.com',
                style: CustomTextStyles.labelLargeSFProTextGray600),
            SizedBox(height: 27.v),
            _sectionRowNameSurNameChous(
              context,
              action: 'Имя',
              action1:
                  read.currentName ?? read.snapShot?.data?.name ?? 'Настроить',
              //! надо будет переделать - брать со своего класса
              onTapRow: () => read.showFormName(context),
            ),
            SizedBox(height: 5.v),
            _sectionRowNameSurNameChous(
              context,
              action: 'Фамилия',
              action1: read.currentSurName ??
                  read.snapShot?.data?.surName ??
                  'Настроить',
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
