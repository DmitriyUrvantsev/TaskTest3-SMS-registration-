import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/k0_auth_screen/provider/k0_provider.dart';
import 'package:form_registration/widgets/custom_text_form_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthFieldWidget extends StatelessWidget {
  const AuthFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
        mask: '+#(###) ###-##-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Номер телефона', style: theme.textTheme.labelLarge),
      SizedBox(height: 5.v),
      


      Selector<Screen0Provider, TextEditingController?>(
          selector: (context, provider) =>
              provider.phoneValueController, //!======
          builder: (context, phoneValueController, child) {
            return CustomTextFormField(
              validator: (val) => val != null
                  ? (val.length < 15 ? 'Введите номер телефона' : null)
                  : null,
              //controller: phoneValueController,
              //hintText: '+7',
              prefixText: '+7',
              textInputAction: TextInputAction.done,
              autofocus: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                maskFormatter
              ],

              // validator: (val) => val != null
              //     ? (val.length < 15 ? 'Введите номер телефона' : null)
              //     : null,

              // //labelText: '+7',
              // //labelStyle: CustomTextStyles.bodyLargeOnPrimaryTransparent,
              // //hintText: '(***) ***-**-**',
              // prefixText: '+7',
              // autofocus: false,
              // keyboardType: TextInputType.number,
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              //   maskFormatter
              // ],
            );
          })
    ]);
  }
}
