import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/f0_auth_screen/provider/k0_provider.dart';
import 'package:form_registration/widgets/custom_numdber_form_field.dart';
import 'package:form_registration/widgets/custom_text_form_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthFieldWidget extends StatelessWidget {
  const AuthFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthScreenProvider>();
    final formKey = read.formKey;
    // final controller = read.controller;
    MaskTextInputFormatter maskFormatter = read.maskFormatter;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Номер телефона', style: theme.textTheme.labelLarge),
      SizedBox(height: 5.v),
      Form(
        key: formKey,
        child: Column(
          children: [
            // 
            CustomPhonFormField(
              // controller: controller, //!
              keyboardType: TextInputType.phone,
              onChanged: (p0) => read.phone = p0,
              validator: (val) => val != null
                  ? (val.length < 17 ? 'Введите номер телефона' : null)
                  : null,

              prefixText: '+7',
              textInputAction: TextInputAction.done,
              autofocus: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                maskFormatter
              ],
            ),
          ],
        ),
      )
    ]);
  }
}

//!===============================================

