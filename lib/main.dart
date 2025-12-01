import 'package:flutter/material.dart';
import 'package:job_application/screens/analytics.dart';
import 'package:job_application/screens/homescreen.dart';
import 'package:job_application/screens/loginscreen.dart';
import 'package:job_application/screens/message.dart';
import 'package:job_application/screens/mycompany.dart';
import 'package:job_application/screens/myjob.dart';
import 'package:job_application/screens/postajob.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/dashboard": (context) => const CompanyHomeScreen(),
        "/post-job": (context) => const PostJobScreen(),
        "/my-jobs": (context) => const MyJob(),
        "/my-company": (context) => const Mycompany(),
        "/messages": (context) => const MobileCombinedChatPage(),
        "/analytics": (context) => const MobileDashboardScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
