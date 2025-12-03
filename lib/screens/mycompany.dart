import 'package:flutter/material.dart';
import 'package:job_application/widgets/mainlayout.dart';

class Mycompany extends StatelessWidget {
  const Mycompany({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(bottomNavIndex: 3, drawerIndex: -1, child: Column());
  }
}
