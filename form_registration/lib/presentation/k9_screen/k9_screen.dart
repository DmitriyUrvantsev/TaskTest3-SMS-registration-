import 'package:form_registration/presentation/k9_screen/provider/k9_provider.dart';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_elevated_button.dart';
import 'package:form_registration/widgets/custom_text_form_field.dart';


class K9ScreenWidget extends StatefulWidget {
  const K9ScreenWidget({super.key});

  @override
  K9ScreenWidgetState createState() => K9ScreenWidgetState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Screen9Provider(), child: const K9ScreenWidget());
  }
}

class K9ScreenWidgetState extends State<K9ScreenWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      NavigatorService.popAndPushNamed(
       AppNavigationRoutes.confirmation ,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 2.v),
                child: Column(children: [
                  AnotherStepper(
                      stepperDirection: Axis.horizontal,
                      activeIndex: 0,
                      barThickness: 1,
                      inverted: true,
                      stepperList: [
                        StepperData(),
                        StepperData(),
                        StepperData()
                      ]),
                  SizedBox(height: 27.v),
                  Text("lbl2", style: theme.textTheme.displaySmall),
                  SizedBox(height: 21.v),
                  SizedBox(
                      width: 181.h,
                      child: Text("msg3",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(height: 1.33))),
                  SizedBox(height: 42.v),
                  _buildColumn(context),
                  const Spacer(flex: 33),
                  CustomElevatedButton(
                      text: "msg4",
                      margin: EdgeInsets.symmetric(horizontal: 29.h),
                      onPressed: () {
                       // onTaptf(context);
                      }),
                  SizedBox(height: 8.v),
                  SizedBox(
                      width: 228.h,
                      child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "msg6",
                                style: CustomTextStyles.bodySmallffa7a7a7),
                            TextSpan(
                                text: "msg7",
                                style: CustomTextStyles.bodySmallffffb700)
                          ]),
                          textAlign: TextAlign.center)),
                  const Spacer(flex: 66)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 374.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgVector,
            margin: EdgeInsets.fromLTRB(18.h, 10.v, 341.h, 11.v)));
  }

  /// Section Widget
  Widget _buildColumn(BuildContext context) {
    return GestureDetector(
        onTap: () {
         // onTapColumn(context);
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("lbl3", style: theme.textTheme.labelLarge),
          SizedBox(height: 5.v),
          Selector<Screen9Provider, TextEditingController?>(
              selector: (context, provider) => provider.plusSevenController,
              builder: (context, plusSevenController, child) {
                return CustomTextFormField(
                    controller: plusSevenController,
                    hintText: "lbl_72",
                    textInputAction: TextInputAction.done);
              })
        ]));
  }


}
