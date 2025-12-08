import 'package:flutter/material.dart';
import 'package:job_application/constants/colors.dart';
import 'package:job_application/constants/gap_func.dart';
import 'package:job_application/widgets/elevatedbutton.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool emailEnabled = true;
  bool pushEnabled = false;
  String selectedTab = "Account";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading("Settings", 28),
          Text(
            "Manage your account settings and preferences.",
            style: TextStyle(color: greyColor, fontSize: 16),
          ),
          vertGap(40),
          toggleAccountNotification(
            selected: selectedTab,
            onChanged: (val) {
              setState(() {
                selectedTab = val;
              });
            },
          ),
          vertGap(20),
          if (selectedTab == "Account") ...[
            Container(
              decoration: BoxDecoration(
                // color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading("Account", 24),
                    normalText("Manage your account and security settings."),
                    vertGap(15),
                    Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    vertGap(05),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: normalText("axor@gmail.com"),
                    ),
                    vertGap(05),
                    Divider(),
                    vertGap(10),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        color: redColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    normalText(
                      "Permanently delete your account and all of your content.",
                    ),
                    vertGap(15),
                    CustomElevatedbutton(
                      onpressed: () {},
                      text: "Delete Account",
                      borderRadius: 05,
                      backgroundColor: redColor,
                      foregroundcolor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            notificationSettings(
              emailEnabled: emailEnabled,
              pushEnabled: pushEnabled,
              onEmailChanged: (value) {
                setState(() {
                  emailEnabled = value;
                });
              },
              onPushChanged: (value) {
                setState(() {
                  pushEnabled = value;
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}

Widget heading(String text, double fontsize) {
  return Text(
    text,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontsize),
  );
}

Widget normalText(String text) {
  return Text(text, style: TextStyle(color: greyColor));
}

Widget toggleAccountNotification({
  required String selected,
  required Function(String) onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(2),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            alignment: selected == "Account"
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _ToggleOption(
                  label: "Account",
                  isSelected: selected == "Account",
                  onTap: () => onChanged("Account"),
                ),
              ),
              Expanded(
                child: _ToggleOption(
                  label: "Notifications",
                  isSelected: selected == "Notifications",
                  onTap: () => onChanged("Notifications"),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _ToggleOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? const Color(0xFF1A1A1A)
                : Colors.white.withValues(alpha: 0.6),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

Widget notificationSettings({
  required bool emailEnabled,
  required bool pushEnabled,
  required ValueChanged<bool> onEmailChanged,
  required ValueChanged<bool> onPushChanged,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      // color: primaryColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Notifications",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          "Configure how you receive notifications.",
          style: TextStyle(color: greyColor, fontSize: 15),
        ),
        const SizedBox(height: 20),
        _notificationTile(
          title: "Email Notifications",
          subtitle:
              "Receive emails about new applications, job matches, and messages.",
          value: emailEnabled,
          onChanged: onEmailChanged,
        ),

        const SizedBox(height: 15),

        _notificationTile(
          title: "Push Notifications",
          subtitle: "Get push notifications for important updates.",
          value: pushEnabled,
          onChanged: onPushChanged,
        ),
      ],
    ),
  );
}

Widget _notificationTile({
  required String title,
  required String subtitle,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      color: Colors.grey.shade100,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 5),
              Text(subtitle, style: TextStyle(color: greyColor, fontSize: 14)),
            ],
          ),
        ),

        // Switch Toggle
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: Colors.black,
          inactiveTrackColor: Colors.grey.shade300,
          inactiveThumbColor: Colors.white,
        ),
      ],
    ),
  );
}
