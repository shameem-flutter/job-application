import 'package:flutter/material.dart';
import 'package:job_application/constants/colors.dart';
import 'package:job_application/widgets/mainlayout.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final _jobTitle = TextEditingController();
  final _location = TextEditingController();
  final _minSalary = TextEditingController();
  final _maxSalary = TextEditingController();
  final _keywords = TextEditingController();
  final _description = TextEditingController();

  String jobType = "Full-time";

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Post a New Job",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Fill out the details below to create a new job opening.",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            // -----------------------------------------
            // BASIC JOB DETAILS SECTION
            // -----------------------------------------
            buildSectionTitle("Job Details"),

            buildInput("Job Title", _jobTitle, "e.g., Software Engineer"),
            const SizedBox(height: 20),

            buildInput("Location", _location, "e.g., kozhikode, kerala"),
            const SizedBox(height: 30),

            // -----------------------------------------
            // JOB TYPE & SALARY SECTION
            // -----------------------------------------
            buildSectionTitle("Job Type & Salary"),

            buildDropdown(),
            const SizedBox(height: 20),

            buildInput(
              "Min Salary (₹)",
              _minSalary,
              "0",
              type: TextInputType.number,
            ),
            const SizedBox(height: 20),

            buildInput(
              "Max Salary (₹)",
              _maxSalary,
              "0",
              type: TextInputType.number,
            ),

            const SizedBox(height: 30),

            // -----------------------------------------
            // KEYWORDS SECTION
            // -----------------------------------------
            buildSectionTitle("Keywords"),

            buildInput("Keywords", _keywords, "e.g., Flutter, Dart, Firebase"),

            const SizedBox(height: 30),

            // -----------------------------------------
            // DESCRIPTION SECTION
            // -----------------------------------------
            Row(
              children: [
                buildSectionTitle("Job Description"),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "Generate with AI",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),

            buildTextArea(),

            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Post Job",
                  style: TextStyle(fontSize: 16, color: primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget buildInput(
    String label,
    TextEditingController controller,
    String hint, {
    TextInputType? type,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Job Type",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<String>(
            value: jobType,
            isExpanded: true,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: "Full-time", child: Text("Full-time")),
              DropdownMenuItem(value: "Part-time", child: Text("Part-time")),
              DropdownMenuItem(value: "Internship", child: Text("Internship")),
            ],
            onChanged: (value) {
              setState(() => jobType = value!);
            },
          ),
        ),
      ],
    );
  }

  Widget buildTextArea() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      height: 160,
      child: TextField(
        controller: _description,
        maxLines: null,
        expands: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Describe the job in detail...",
        ),
      ),
    );
  }
}
