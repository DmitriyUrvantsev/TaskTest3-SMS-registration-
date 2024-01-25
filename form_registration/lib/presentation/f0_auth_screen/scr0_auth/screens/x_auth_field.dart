import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/presentation/f0_auth_screen/scr0_auth/provider/k0_provider.dart';
import 'package:form_registration/widgets/custom_text_form_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthFieldWidget extends StatelessWidget {
  const AuthFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<Screen0Provider>();
    final formKey = read.formKey;
    MaskTextInputFormatter maskFormatter = read.maskFormatter;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Номер телефона', style: theme.textTheme.labelLarge),
      SizedBox(height: 5.v),
      Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
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

// class AuthFieldWidget extends StatelessWidget {
//   const AuthFieldWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//           final _formKey = GlobalKey<FormState>();
//     // Build a Form widget using the _formKey created above.
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//            CustomTextFormField(
//             // The validator receives the text that the user has entered.
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: MyButton(formKey: _formKey),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyButton extends StatelessWidget {
//   const MyButton({
//     super.key,
//     required GlobalKey<FormState> formKey,
//   }) : _formKey = formKey;

//   final GlobalKey<FormState> _formKey;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         // Validate returns true if the form is valid, or false otherwise.
//         if (_formKey.currentState?.validate() ?? false) {
//           // If the form is valid, display a snackbar. In the real world,
//           // you'd often call a server or save the information in a database.
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Processing Data')),
//           );
//         }
//       },
//       child: const Text('Submit'),
//     );
//   }
// }
