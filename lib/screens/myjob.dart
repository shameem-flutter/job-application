import 'package:flutter/material.dart';
import 'package:job_application/constants/colors.dart';
import 'package:job_application/constants/gap_func.dart';
import 'package:job_application/widgets/mainlayout.dart';

class MyJob extends StatelessWidget {
  const MyJob({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      bottomNavIndex: 1,
      drawerIndex: -1,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Job Postings",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: secondaryColor),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Icon(Icons.image, size: 50),
                            ),
                            horiGap(10),
                            texts("axor", "mern stack"),
                            horiGap(20),
                            Icon(Icons.more_horiz),
                          ],
                        ),
                        vertGap(20),
                        Text('Applicants', style: TextStyle(color: greyColor)),
                        applicantNo(Icons.people_outline, "2"),
                        elevatedButton("View Pipeline", () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget texts(String title, String subtitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title),
      Text(
        subtitle,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget applicantNo(IconData icon, String number) {
  return Row(
    children: [
      Icon(icon),
      horiGap(05),
      Text(number, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    ],
  );
}

Widget elevatedButton(String text, VoidCallback onpressed) {
  return ElevatedButton(
    onPressed: onpressed,
    style: ElevatedButton.styleFrom(),
    child: Text(text),
  );
}
