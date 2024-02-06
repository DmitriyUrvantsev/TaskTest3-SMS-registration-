// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/folder0_auth_screen/provider/k0_provider.dart';
import 'package:form_registration/presentation/folder0_auth_screen/screens/widgets/stepper_confirmation.dart';
import 'package:form_registration/widgets/app_bar/appbar_leading_image.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_pin_code_text_field.dart';

class K1ConfirmationScreenWidget extends StatefulWidget {
  final String verificationId;

  const K1ConfirmationScreenWidget({
    super.key,
    required this.verificationId,
  });

  @override
  State<K1ConfirmationScreenWidget> createState() =>
      _K1ConfirmationScreenWidgetState();
}

class _K1ConfirmationScreenWidgetState
    extends State<K1ConfirmationScreenWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final read = context.read<AuthScreenProvider>();
      read.start = 60;
      read.startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthScreenProvider>();
    final watch = context.watch<AuthScreenProvider>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _sectionAppBar(context),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
                horizontal: 51.adaptSize, vertical: 2.adaptSize),
            child: Column(children: [
              const Stepper2ScrWidget(),
              SizedBox(height: 20.v),
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

              Padding(
                  padding: EdgeInsets.only(left: 4.h, right: 5.h),
                  child: CustomPinCodeTextField(
                      context: context,
                      controller: read.otpController,
                      onChanged: (value) {
                        read.otpController.text = value;
                      },
                      onCompleted: (value) async {
                        read.confirmation(
                            context, value, widget.verificationId);
                      })),
              SizedBox(height: 43.v),

              //!================================================

              GestureDetector(
                onTap: watch.isPossibleSentCode == false
                    ? () {}
                    : () {
                        read.register(context);
                      },
                child: watch.isPossibleSentCode == false
                    ? Text('${watch.start} сек до повтора отправки кода',
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
