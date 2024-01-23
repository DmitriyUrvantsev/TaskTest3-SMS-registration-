import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';
import 'package:form_registration/widgets/custom_bottom_bar.dart';
import 'provider/k10_provider.dart';

class K10ScreenWidget extends StatefulWidget {
  const K10ScreenWidget({super.key});

  @override
  K10ScreenWidgetState createState() => K10ScreenWidgetState();
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Screen10Provider(),
      child: const K10ScreenWidget(),
    );
  }
}

class K10ScreenWidgetState extends State<K10ScreenWidget> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                height: 10.v,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: appTheme.gray100,
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.black9004c,
                      spreadRadius: 2.h,
                      blurRadius: 2.h,
                      offset: const Offset(
                        0,
                        1,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
    );
  }
}
