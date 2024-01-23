import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/appbar_subtitle.dart';
import 'package:form_registration/widgets/app_bar/appbar_title.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_bottom_bar.dart';
import 'provider/k7_provider.dart';

class K7ScreenWidget extends StatefulWidget {
  const K7ScreenWidget({super.key});

  @override
  K7ScreenWidgetState createState() => K7ScreenWidgetState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Screen7Provider(), child: const K7ScreenWidget());
  }
}

// ignore_for_file: must_be_immutable
class K7ScreenWidgetState extends State<K7ScreenWidget> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray100,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 24.v),
                child: Column(children: [
                  SizedBox(
                      height: 79.v,
                      width: 78.h,
                      child: Stack(alignment: Alignment.topLeft, children: [
                        CustomImageView(
                            imagePath: ImageConstant.imgClose,
                            height: 59.adaptSize,
                            width: 59.adaptSize,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 6.h)),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                height: 76.v,
                                width: 73.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: fs.Svg(ImageConstant.imgGroup1),
                                        fit: BoxFit.cover)),
                                child: CustomImageView(
                                    imagePath: ImageConstant.imgEllipse8,
                                    height: 76.v,
                                    width: 73.h,
                                    radius: BorderRadius.circular(38.h),
                                    alignment: Alignment.center))),
                        CustomImageView(
                            imagePath: ImageConstant.imgCloseGray100,
                            height: 31.v,
                            width: 32.h,
                            alignment: Alignment.bottomRight)
                      ])),
                  SizedBox(height: 13.v),
                  Text("msg_apollon_gmail_com",
                      style: CustomTextStyles.labelLargeSFProTextGray600),
                  SizedBox(height: 27.v),
                  _buildRow(context, action: "lbl8", action1: "lbl11",
                      onTapRow: () {
                  //  onTapRow(context);
                  }),
                  SizedBox(height: 5.v),
                  _buildRow(context, action: "lbl10", action1: "lbl12")
                ])),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 43.v,
        leadingWidth: 28.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowRight,
            margin: EdgeInsets.only(left: 8.h, top: 9.v, bottom: 12.v)),
        title: Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Row(children: [
              AppbarSubtitle(
                  text: "lbl7", margin: EdgeInsets.only(bottom: 1.v)),
              AppbarTitle(text: "lbl4", margin: EdgeInsets.only(left: 26.h))
            ])),
        styleType: Style.bgShadow);
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {});
  }

  /// Common widget
  Widget _buildRow(
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
            padding: EdgeInsets.fromLTRB(16.h, 13.v, 16.h, 12.v),
            decoration: AppDecoration.outlineGray,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(action,
                  style: CustomTextStyles.bodyLargeOnPrimary
                      .copyWith(color: theme.colorScheme.onPrimary)),
              const Spacer(),
              Text(action1,
                  style: CustomTextStyles.bodyLargeGray600
                      .copyWith(color: appTheme.gray600)),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRightGray400,
                  height: 21.v,
                  width: 20.h,
                  margin: EdgeInsets.only(left: 11.h))
            ])));
  }


}
