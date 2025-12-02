import 'package:flutter/material.dart';
import 'package:job_application/widgets/mainlayout.dart';

class MyJob extends StatelessWidget {
  const MyJob({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(selectedIndex: 2, child: Column());
  }
}
