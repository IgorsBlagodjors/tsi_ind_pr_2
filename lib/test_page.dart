import 'package:flutter/material.dart';
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
              AppIcons.favouriteContainer(),
              AppIcons.doctorsContainer(),
              AppIcons.pharmasyContainer(),
              AppIcons.specialtiesContainer(),
              AppIcons.doctorInfo,
            ],
          ),
        ),
      ),
    );
  }
}
