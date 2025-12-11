import 'package:flutter/material.dart';
import 'package:job_application/widgets/mainlayout.dart';

class CandidateHomeScreen extends StatefulWidget {
  const CandidateHomeScreen({super.key});

  @override
  State<CandidateHomeScreen> createState() => _CandidateHomeScreenState();
}

class _CandidateHomeScreenState extends State<CandidateHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout();
  }
}
