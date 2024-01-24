import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';

// ignore: must_be_immutable
class AppbarLeadingImage extends StatelessWidget {
  AppbarLeadingImage({
    super.key,
    this.imagePath,
    this.margin,
    this.onTap,
  });

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return
        // InkWell(
        //   onTap: () {
        //     onTap!.call();
        //   },
        //   child:
        Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: CustomImageView(
          color: PrimaryColors().gray800,
          imagePath: imagePath,
          height: 20.v,
          width: 15.h,
          fit: BoxFit.contain,
        ),
      ),
      //),
    );
  }
}
