// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';

import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/f0_auth_screen/provider/k0_provider.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_pin_code_text_field.dart';

class K1AuthScreenWidget extends StatefulWidget {
  //!final String verificationId;

  const K1AuthScreenWidget({
    super.key,
    //!required this.verificationId,
  });

  @override
  State<K1AuthScreenWidget> createState() => _K1AuthScreenWidgetState();
}

class _K1AuthScreenWidgetState extends State<K1AuthScreenWidget> {
  Timer? _timer;
  int _start = 61;
  bool _isPossibleSentCode = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
                _isPossibleSentCode = true;
              } else {
                _start = _start - 1;
              }
            }));
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthScreenProvider>();
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
                  child: Text(
                      'Введите номер телефона для регистрации', //!===========
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:
                          theme.textTheme.bodyMedium!.copyWith(height: 1.33))),
              SizedBox(height: 61.v),
              //!==========================================
              Padding(
                  padding: EdgeInsets.only(left: 4.h, right: 5.h),
                  child: Selector<AuthScreenProvider, TextEditingController?>(
                      //!=========ЭТО НУЖНО ВООБЩЕ?
                      selector: (context, provider) => provider.otpController,
                      builder: (context, otpController, child) {
                        return CustomPinCodeTextField(
                            context: context,
                            controller:
                                otpController, //! здесь null вызодит типа disposnuto уже
                            onChanged: (value) {
                              otpController?.text = value;
                            },
                            onCompleted: (value) async {
                              read.confirmation(
                                  context,
                                  value,
                                  //!  widget.verificationId
                                  232342434234);
                            });
                      })),
              SizedBox(height: 43.v),

              //!================================================
              GestureDetector(
                onTap: _isPossibleSentCode == false
                    ? () {}
                    : () {
                        read.register(context);
                      },
                child: _isPossibleSentCode == false
                    ? Text('$_start сек до повтора отправки кода',
                        style:
                            theme.textTheme.bodyMedium!.copyWith(height: 1.33))
                    : Text('Отправить код еще раз',
                        style: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.33, color: PrimaryColors().amber600)),
              ),

              SizedBox(height: 5.v)
            ])));
  }

  /// Section Widget
  PreferredSizeWidget _sectionAppBar(BuildContext context) {
    final read = context.read<AuthScreenProvider>();
    return CustomAppBar(
        leadingWidth: 374.h,
        leading: AppbarLeadingImage(
            onTap: () {
              read.backPop(context);
            },
            imagePath: ImageConstant.imgVector,
            color: PrimaryColors().gray800,
            margin: EdgeInsets.fromLTRB(18.h, 10.v, 341.h, 11.v)));
  }
}
