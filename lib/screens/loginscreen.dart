import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:job_application/candidate/screens/candidatesection.dart';
import 'package:job_application/constants/colors.dart';
import 'package:job_application/constants/gap_func.dart';
import 'package:job_application/screens/signupscreen.dart';
import 'package:job_application/widgets/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obsecure = true;

  static const _hint = Color(0xFF9CA3AF);
  static const _titleDark = Color(0xFF111827);

  @override
  void initState() {
    _emailCtrl.addListener(() => setState(() {}));
    _passCtrl.addListener(() => setState(() {}));
    super.initState();
  }

  bool get isValid {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    final emailOk = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
    return emailOk && pass.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                // LOGO
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 22,
                      width: 22,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Brand(Brands.mini_cooper),
                    ),
                    horiGap(10),
                    const Text(
                      "Job Application",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: _titleDark,
                      ),
                    ),
                  ],
                ),

                vertGap(6),

                const Text(
                  "Welcome back!",
                  style: TextStyle(color: Color(0xFF6B7280), fontSize: 15),
                ),

                vertGap(36),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your email address",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _titleDark,
                    ),
                  ),
                ),

                vertGap(05),
                CustomInputField(
                  controller: _emailCtrl,
                  hint: "name@example.com",
                  keyboardType: TextInputType.emailAddress,
                ),

                vertGap(22),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: dark,
                    ),
                  ),
                ),

                vertGap(10),

                CustomInputField(
                  controller: _passCtrl,
                  hint: "Enter your password",
                  obscure: _obsecure,
                  suffix: IconButton(
                    onPressed: () => setState(() {
                      _obsecure = !_obsecure;
                    }),
                    icon: Icon(
                      _obsecure ? Icons.visibility : Icons.visibility_off,
                      color: _hint,
                    ),
                  ),
                ),

                vertGap(10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                vertGap(20),

                // LOGIN BUTTON
                _buildContinueButton(),

                vertGap(22),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Container(height: 1, color: Color(0xFFE5E7EB)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("or", style: TextStyle(color: _hint)),
                    ),
                    Expanded(
                      child: Container(height: 1, color: Color(0xFFE5E7EB)),
                    ),
                  ],
                ),

                vertGap(18),

                _SocialButton(
                  label: "Continue with Google",
                  leading: Brand(Brands.google, size: 20),
                  onTap: () {},
                ),

                vertGap(12),

                _SocialButton(
                  label: "Continue with Apple",
                  leading: Brand(Brands.apple_logo, size: 20),
                  onTap: () {},
                ),

                vertGap(28),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an account?",
                      style: TextStyle(color: _hint),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                vertGap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    final active = isValid;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 56,
      decoration: BoxDecoration(
        color: active ? green : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(28),
      ),
      child: TextButton(
        onPressed: active
            ? () async {
                final prefs = await SharedPreferences.getInstance();
                final email = _emailCtrl.text.trim();
                final role = prefs.getString("role_$email");

                if (role == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please create an account first ")),
                  );
                  return;
                }
                if (role == "company") {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/dashboard",
                    (route) => false,
                  );
                } else if (role == "candidate") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => CandidateHomeScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Invalid role saved")));
                }
              }
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Login",
              style: TextStyle(
                color: _titleDark,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget leading;
  final VoidCallback? onTap;
  const _SocialButton({required this.label, required this.leading, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading,
            horiGap(12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
