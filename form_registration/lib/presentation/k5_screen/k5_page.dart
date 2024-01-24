import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/appbar_subtitle.dart';
import 'package:form_registration/widgets/app_bar/appbar_title.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_text_form_field.dart';
import 'provider/k5_provider.dart';

// ignore_for_file: must_be_immutable
class K5ScreenWidget extends StatefulWidget {
  const K5ScreenWidget({super.key});

  @override
  K5ScreenWidgetState createState() => K5ScreenWidgetState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Screen5Provider(),
      child: const K5ScreenWidget(),
    );
  }
}

class K5ScreenWidgetState extends State<K5ScreenWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Selector<Screen5Provider, TextEditingController?>(
                selector: (
                  context,
                  provider,
                ) =>
                    provider.yourNameController,
                builder: (context, yourNameController, child) {
                  return CustomTextFormField(
                    controller: yourNameController,
                    hintText: "lbl5",
                    textInputAction: TextInputAction.done,
                    borderDecoration:
                        TextFormFieldStyleHelper.fillOnPrimaryContainer,
                    filled: true,
                    fillColor: theme.colorScheme.onPrimaryContainer,
                  );
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 43.v,
      leadingWidth: 28.h,
      leading: AppbarLeadingImage(
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
              text: "lbl4",
              margin: EdgeInsets.only(top: 1.v),
            ),
            AppbarTitle(
              text: "lbl5",
              margin: EdgeInsets.only(left: 53.h),
            ),
          ],
        ),
      ),
      styleType: Style.bgShadow,
    );
  }
}
