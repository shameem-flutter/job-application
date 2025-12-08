import 'package:flutter/material.dart';
import 'package:job_application/constants/colors.dart';

class CurvedBNB extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CurvedBNB({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: "Home",
            index: 0,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.work_outline,
            label: "Jobs",
            index: 1,
            currentIndex: currentIndex,
            onTap: onTap,
          ),

          // ---- Smaller Center Action Button ----
          GestureDetector(
            onTap: () => onTap(2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                gradient: currentIndex == 2
                    ? LinearGradient(
                        colors: [Colors.blue.shade600, Colors.purple.shade600],
                      )
                    : LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.85),
                          Colors.white.withValues(alpha: 0.95),
                        ],
                      ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: currentIndex == 2
                        ? Colors.blue.withValues(alpha: 0.35)
                        : Colors.black.withValues(alpha: 0.06),
                    blurRadius: currentIndex == 2 ? 12 : 8,
                    spreadRadius: currentIndex == 2 ? 2 : 0.5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                size: 28,
                color: currentIndex == 2 ? Colors.white : primaryColor,
              ),
            ),
          ),

          _NavItem(
            icon: Icons.messenger_outline_sharp,
            label: "Messages",
            index: 3,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: "Company",
            index: 4,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

/// COMPONENT: left/right items
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedScale(
        scale: isActive ? 1.12 : 1.0,
        duration: const Duration(milliseconds: 180),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: isActive ? Colors.white : greyColor),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                color: isActive ? Colors.white : greyColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),

            /// Small indicator dot
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 4,
                width: 4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
