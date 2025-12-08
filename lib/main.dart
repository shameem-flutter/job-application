import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_application/screens/analytics.dart';
import 'package:job_application/screens/candidate.dart';
import 'package:job_application/screens/loginscreen.dart';
import 'package:job_application/screens/message.dart';
import 'package:job_application/screens/mycompany.dart';
import 'package:job_application/screens/myjob.dart';
import 'package:job_application/screens/postajob.dart';
import 'package:job_application/screens/signupscreen.dart';
import 'package:job_application/widgets/mainlayout.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/dashboard": (context) => const MainLayout(),
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const SignupScreen(),
        "/post-job": (context) => const PostJobScreen(),
        "/my-jobs": (context) => const MyJob(),
        "/my-company": (context) => const Mycompany(),
        "/messages": (context) => const MobileCombinedChatPage(),
        "/analytics": (context) => const MobileDashboardScreen(),
        "/candidate": (context) => const CandidateScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
