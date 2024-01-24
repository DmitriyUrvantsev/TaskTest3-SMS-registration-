import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/appbar_subtitle.dart';
import 'package:form_registration/widgets/app_bar/appbar_title.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_bottom_bar.dart';
import 'provider/k3_provider.dart';

class K3AccounrScreenWidget extends StatefulWidget {
  const K3AccounrScreenWidget({super.key});

  @override
  K3AccounrScreenWidgetState createState() => K3AccounrScreenWidgetState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Screen3AccountProvider(),
        child: const K3AccounrScreenWidget());
  }
}

// ignore_for_file: must_be_immutable
class K3AccounrScreenWidgetState extends State<K3AccounrScreenWidget> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<Screen3AccountProvider>();
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray100,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 24.v),
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgContrast,
                      height: 76.v,
                      width: 73.h),
                  SizedBox(height: 17.v),
                  Text("msg_apollo_gmail_com",
                      style: CustomTextStyles.labelLargeSFProTextGray600),
                  SizedBox(height: 27.v),
                  _buildRow(context, action: "lbl8", action1: "lbl9",
                      onTapRow: () {
                    //  onTapRow(context);
                  }),
                  SizedBox(height: 5.v),
                  _buildRow(context, action: "lbl10", action1: "lbl9")
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
                          .copyWith(color: appTheme.gray400))),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRightGray400,
                  height: 21.v,
                  width: 20.h,
                  margin: EdgeInsets.only(left: 10.h))
            ])));
  }
}
