import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/widgets/main_pincode_textfield/main_pin_code_textfield.dart';
import 'package:form_registration/widgets/main_pincode_textfield/models/pin-theme.dart';

//import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField({
    super.key,
    required this.context,
    required this.onChanged,
    this.alignment,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.validator,
  });

  final Alignment? alignment;
  final BuildContext context;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  Function(String) onChanged;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget,
          )
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => MainPinCodeTextField(
        appContext: context,
        controller: controller,
        autoFocus: true,
        length: 5,
        keyboardType: TextInputType.number,
        textStyle: textStyle ?? theme.textTheme.headlineMedium,
        hintStyle: hintStyle ?? theme.textTheme.headlineMedium,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        enableActiveFill: true,
        pinTheme: PinTheme(
          fieldHeight: 40.h,
          fieldWidth: 40.h,
          // shape: PinCodeFieldShape.underline,
          inactiveFillColor: theme.colorScheme.primary,
          activeFillColor: theme.colorScheme.primary,
          inactiveColor: Colors.transparent,
          activeColor: Colors.transparent,
          selectedColor: Colors.transparent,
        ),
        onChanged: (value) => onChanged(value),
        validator: validator,
      );
}
