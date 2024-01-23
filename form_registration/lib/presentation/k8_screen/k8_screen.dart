import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/k8_screen/provider/k8_provider.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/appbar_subtitle.dart';
import 'package:form_registration/widgets/app_bar/appbar_title.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_bottom_bar.dart';
import 'package:form_registration/widgets/custom_text_form_field.dart';
//import 'provider/k9_provider.dart';

class K8ScreenWidget extends StatefulWidget {
  const K8ScreenWidget({super.key});

  @override
  K8ScreenWidgetState createState() => K8ScreenWidgetState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Screen8Provider(),
      child: const K8ScreenWidget(),
    );
  }
}

class K8ScreenWidgetState extends State<K8ScreenWidget> {
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
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 24.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.h,
                  right: 9.h,
                ),
                child: Selector<Screen8Provider, TextEditingController?>(
                  selector: (
                    context,
                    provider,
                  ) =>
                      provider.yourLastNameController,
                  builder: (context, yourLastNameController, child) {
                    return CustomTextFormField(
                      controller: yourLastNameController,
                      hintText: "lbl13",
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
        bottomNavigationBar: _buildBottomBar(context),
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
              text: "lbl13",
              margin: EdgeInsets.only(left: 32.h),
            ),
          ],
        ),
      ),
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
    );
  }
}
