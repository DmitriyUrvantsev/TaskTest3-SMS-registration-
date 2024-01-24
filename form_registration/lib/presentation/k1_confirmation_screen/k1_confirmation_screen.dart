import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_pin_code_text_field.dart';
import 'provider/k1_provider.dart';

class K1AuthScreenWidget extends StatelessWidget {
  const K1AuthScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<Screen1Provider>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _sectionAppBar(context),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 51.h, vertical: 2.v),
            child: Column(children: [
              //?========================
              AnotherStepper(
                  stepperDirection: Axis.horizontal,
                  activeIndex: 0,
                  barThickness: 1,
                  inverted: true,
                  stepperList: [
                    StepperData(),
                    StepperData(),
                    StepperData(),
                  ]),
              //?========================

              SizedBox(height: 25.v),
              Text('Подтверждение',
                  style: theme
                      .textTheme.displaySmall), //?.copyWith(fontSize: 34)),
              SizedBox(height: 20.v),
              Container(
                  width: 261.h,
                  margin: EdgeInsets.only(left: 5.h, right: 6.h),
                  child: Text('Введите номер телефона для регистрации',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:
                          theme.textTheme.bodyMedium!.copyWith(height: 1.33))),
              SizedBox(height: 61.v),
              //!==========================================
              Padding(
                  padding: EdgeInsets.only(left: 4.h, right: 5.h),
                  child: Selector<Screen1Provider, TextEditingController?>(
                      selector: (context, provider) => provider.otpController,
                      builder: (context, otpController, child) {
                        return CustomPinCodeTextField(
                            context: context,
                            controller: otpController,
                            onChanged: (value) {
                              otpController?.text = value;
                              print(value);
                            },
                            onCompleted: (value) {
                              read.showMainScreen(context);
                              print(value + value);
                            });
                      })),
              SizedBox(height: 43.v),

              //!================================================
              GestureDetector(
                  onTap: () {
                    //!onTapTxtWidget(context);
                  },
                  child: Text('60 сек до повтора отправки кода',
                      style:
                          theme.textTheme.bodyMedium!.copyWith(height: 1.33))),
              SizedBox(height: 5.v)
            ])));
  }

  /// Section Widget
  PreferredSizeWidget _sectionAppBar(BuildContext context) {
    final read = context.read<Screen1Provider>();
    return CustomAppBar(
        leadingWidth: 374.h,
        leading: AppbarLeadingImage(
          onTap: () => read.backPop(context),
            imagePath: ImageConstant.imgVector, 

            margin: EdgeInsets.fromLTRB(18.h, 10.v, 341.h, 11.v)));
  }
}
