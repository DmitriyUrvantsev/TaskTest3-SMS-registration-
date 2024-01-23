import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/k0_auth_screen/provider/k0_provider.dart';
import 'package:form_registration/widgets/custom_text_form_field.dart';

class AuthFieldWidget extends StatelessWidget {
  const AuthFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Номер телефона', style: theme.textTheme.labelLarge),
      SizedBox(height: 5.v),
      Selector<Screen0Provider, TextEditingController?>(
          selector: (context, provider) =>
              provider.phoneValueController, //!======
          builder: (context, phoneValueController, child) {
            return CustomTextFormField(
              controller: phoneValueController,
              hintText: '+7',
              textInputAction: TextInputAction.done,
              autofocus: false,
            );
          })
    ]);
  }
}
