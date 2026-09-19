import 'package:flutter/material.dart';
import 'package:tsi_ind_pr_2/design_system/app_buttons.dart';
import 'package:tsi_ind_pr_2/design_system/app_containers.dart';
import 'package:tsi_ind_pr_2/design_system/app_icons.dart';

class TestPage extends StatefulWidget {
  const new({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIcons.analysis(),
              AppIcons.vaccinations(),
              AppIcons.allergies(),
              AppIcons.medicalHistory(),
              AppIcons.analysis(big: true),
              AppIcons.vaccinations(big: true),
              AppIcons.allergies(big: true),
              AppIcons.medicalHistory(big: true),
            ],
          ),
        ),
      ),
    );
  }
}
