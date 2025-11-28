import 'package:flutter/material.dart';
import 'package:job_application/constants/colors.dart';

class CurvedBNB extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CurvedBNB({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      shape: const CircularNotchedRectangle(),
      notchMargin: 7,
      color: secondaryColor,
      surfaceTintColor: secondaryColor,
      shadowColor: primaryColor,
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildIcon(Icons.home, 0),
          buildIcon(Icons.work_outline, 1),
          const SizedBox(width: 40), // SPACE for FAB
          buildIcon(Icons.bookmark_outline, 2),
          buildIcon(Icons.person_outline, 3),
        ],
      ),
    );
  }

  Widget buildIcon(IconData icon, int i) {
    return IconButton(
      onPressed: () => onTap(i),
      icon: Icon(
        icon,
        size: 28,
        color: currentIndex == i ? primaryColor : Colors.grey.shade500,
      ),
    );
  }
}
