import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/widgets/custom_pin_code_text_field.dart';
import 'provider/k4_provider.dart';

class K4ProjectsScreenWidget extends StatelessWidget {
  const K4ProjectsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 51.h,
          vertical: 2.v,
        ),
        child: Column(
          children: [
            Text(
              'Мои проекты',
              style: theme.textTheme.displaySmall!.copyWith(fontSize: 24),
            ),
            SizedBox(height: 20.v),
          ],
        ),
      ),
    );
  }
}
