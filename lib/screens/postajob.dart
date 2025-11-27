import 'package:flutter/material.dart';
import 'package:job_application/widgets/mainlayout.dart';

class PostaJob extends StatefulWidget {
  const PostaJob({super.key});

  @override
  State<PostaJob> createState() => _PostaJobState();
}

class _PostaJobState extends State<PostaJob> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(selectedIndex: 1, child: Column(children: []));
  }
}
