import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:form_registration/core/app_export.dart';

class StepperAuthScreenWidget extends StatefulWidget {
  const StepperAuthScreenWidget({Key? key}) : super(key: key);

  @override
  State<StepperAuthScreenWidget> createState() =>
      _StepperAuthScreenWidgetState();
}

class _StepperAuthScreenWidgetState extends State<StepperAuthScreenWidget> {
  List<StepperData> stepperData = [
    StepperData(
        iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: PrimaryColors().amber600,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: const Center(child: Text('1')),
    )),
    StepperData(
        iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: PrimaryColors().gray200,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: const Center(child: Text('2')),
    )),
    StepperData(
        iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: PrimaryColors().gray200,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: const Center(child: Text('3')),
    )),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnotherStepper(
          stepperList: stepperData,
          stepperDirection: Axis.horizontal,
          iconWidth: 36.fSize,
          iconHeight: 36.fSize,
          activeBarColor: PrimaryColors().gray200,
          inActiveBarColor: PrimaryColors().gray200,
          inverted: true,
          verticalGap: 30,
          activeIndex: 1,
          barThickness: 1,
        ),
      ],
    );
  }
}
