import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/widgets/app_bar/custom_app_bar.dart';
import 'package:form_registration/widgets/custom_pin_code_text_field.dart';


class K4ProjectsScreenWidget extends StatelessWidget {
  const K4ProjectsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _sectionAppBar(context),
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

  /// Section AppBar ===========================================================
  PreferredSizeWidget _sectionAppBar(BuildContext context) {
    return CustomAppBar(
      height: 25.v,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: PrimaryColors().gray600,
          height: 1.0,
        ),
      ),
    );
  }
}
