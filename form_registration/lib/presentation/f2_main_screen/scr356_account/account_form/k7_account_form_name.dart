// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/f2_main_screen/provider/k2_provider.dart';
import 'package:form_registration/theme/app_decoration.dart';
import 'package:form_registration/theme/theme_helper.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/appbar_subtitle.dart';
import 'package:form_registration/widgets/app_bar/appbar_title.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_text_form_field.dart';

class K7AccountFormNameWidget extends StatelessWidget {
  const K7AccountFormNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<Screen2Provider>();
    final formKey = read.formKey;
    return Scaffold(
      backgroundColor: appTheme.gray100,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: Container(
        width: double.maxFinite,
        decoration: AppDecoration.fillGray100,
        child: Column(
          children: [
            SizedBox(height: 24.v),
            Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                right: 9.h,
              ),
              child: Form(
                key:  formKey,
                child: CustomTextFormField(
                   validator: (val) => val != null
                  ? (val.isEmpty ? 'Введите Ваше имя' : null)
                  : null,
                  controller: read.yourNameController,
                  hintText: 'Ваше имя',
                  textInputAction: TextInputAction.done,
                  borderDecoration:
                      TextFormFieldStyleHelper.fillOnPrimaryContainer,
                  filled: true,
                  fillColor: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  /// ======================AppBar==============================================
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final read = context.read<Screen2Provider>();
    return CustomAppBar(
      height: 43.v,
      leadingWidth: 28.h,
      leading: AppbarLeadingImage(
        onTap: () => read.backToAccount(context),
        color: PrimaryColors().lightBlueA700,
        imagePath: ImageConstant.imgArrowRight,
        margin: EdgeInsets.only(
          left: 8.h,
          top: 9.v,
          bottom: 12.v,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 2.h),
        child: Row(
          children: [
            AppbarSubtitle(
              onTap: () => read.backToAccount(context),
              text: 'Аккаунт',
              margin: EdgeInsets.only(top: 1.v),
            ),
            AppbarTitle(
              onTap: () {},
              text: 'Ваше имя',
              margin: EdgeInsets.only(left: 53.h),
            ),
          ],
        ),
      ),
      styleType: Style.bgShadow,
    );
  }
}
