import 'package:flutter/material.dart';

class CustomElevatedbutton extends StatelessWidget {
  final double? height;
  final double? width;
  final VoidCallback onpressed;
  final String text;
  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundcolor;
  final double borderRadius;
  const CustomElevatedbutton({
    super.key,
    this.height,
    this.width,
    required this.onpressed,
    required this.text,
    this.foregroundcolor,
    this.elevation,
    this.backgroundColor,
    required this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
