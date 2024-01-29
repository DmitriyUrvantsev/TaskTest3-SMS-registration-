import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/f0_auth_screen/screens/k0_auth_field_widget.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_elevated_button.dart';
import '../provider/k0_provider.dart';

class K0AuthScreenWidget extends StatelessWidget {
  const K0AuthScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthScreenProvider>();
    //final formKey = GlobalKey<FormState>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 2.v),
            child: Column(children: [
              //?==================
              SizedBox(
                width: 196.fSize,
                child: AnotherStepper(
                    stepperDirection: Axis.horizontal,
                    activeIndex: 0,
                    barThickness: 1,
                    inverted: true,
                    stepperList: [
                      StepperData(),
                      StepperData(),
                      StepperData(),
                    ]),
              ),
              //?==================
              SizedBox(height: 27.v),
              Text('Регистрация', style: theme.textTheme.displaySmall),
              SizedBox(height: 21.v),
              SizedBox(
                  width: 199.h,
                  child: Text('Введите номер телефона для регистрации',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:
                          theme.textTheme.bodyMedium!.copyWith(height: 1.33))),
              SizedBox(height: 42.v),
              const AuthFieldWidget(),
              const Spacer(flex: 33),
              CustomElevatedButton(
                  text: 'Отправить смс-код',
                  margin: EdgeInsets.symmetric(horizontal: 29.h),
                  buttonStyle: CustomButtonStyles.fillAmber,
                  onPressed: () {
                    read.register(context);
                  }),
              SizedBox(height: 8.v),
              SizedBox(
                  width: 228.h,
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                'Нажимая на данную кнопку, вы даете согласие на обработку ',
                            style: CustomTextStyles.bodySmallffa7a7a7),
                        TextSpan(
                            text: 'персональных данных',
                            style: CustomTextStyles.bodySmallffffb700)
                      ]),
                      textAlign: TextAlign.center)),
              const Spacer(flex: 66)
            ])));
  }
}
