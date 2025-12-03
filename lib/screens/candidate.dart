import 'package:flutter/material.dart';
import 'package:job_application/widgets/mainlayout.dart';

class CandidateScreen extends StatefulWidget {
  const CandidateScreen({super.key});

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(bottomNavIndex: -1, drawerIndex: 2, child: Column());
  }
}
