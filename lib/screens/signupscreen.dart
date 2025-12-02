import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:job_application/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _obscure = true;
  String _role = "Candidate (Looking for a job)";

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 1100,
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        const Text(
                          "Create an Account",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 6),

                        const Text(
                          "Join UpMatch as a Candidate or a Company",
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 32),

                        _buildLabel("I am a..."),
                        const SizedBox(height: 8),

                        // DROPDOWN
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: _boxDecoration(),
                          child: DropdownButtonFormField(
                            initialValue: _role,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "Candidate (Looking for a job)",
                                child: Text("Candidate (Looking for a job)"),
                              ),
                              DropdownMenuItem(
                                value: "Company (Hiring talent)",
                                child: Text("Company (Hiring talent)"),
                              ),
                            ],
                            onChanged: (v) =>
                                setState(() => _role = v.toString()),
                          ),
                        ),

                        const SizedBox(height: 16),

                        _socialButton(
                          icon: Brand(Brands.google, size: 22),
                          text: "Sign up with Google",
                          onTap: () {},
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(child: _divider()),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text("OR SIGN UP WITH EMAIL"),
                            ),
                            Expanded(child: _divider()),
                          ],
                        ),

                        const SizedBox(height: 20),

                        _buildLabel("Full Name"),
                        const SizedBox(height: 8),
                        _field(controller: _nameCtrl, hint: "e.g. Jane Doe"),

                        const SizedBox(height: 20),

                        _buildLabel("Email"),
                        const SizedBox(height: 8),
                        _field(
                          controller: _emailCtrl,
                          hint: "your@email.com",
                          keyboard: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 20),

                        _buildLabel("Password"),
                        const SizedBox(height: 8),

                        _field(
                          controller: _passCtrl,
                          hint: "Enter your password",
                          obscure: _obscure,
                          suffix: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xFF9CA3AF),
                            ),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                        ),

                        const SizedBox(height: 28),

                        SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF111827),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              final name = _nameCtrl.text.trim();
                              final email = _emailCtrl.text.trim();
                              final pass = _passCtrl.text.trim();

                              if (name.isEmpty ||
                                  email.isEmpty ||
                                  pass.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Fill all fields"),
                                  ),
                                );
                                return;
                              }

                              final prefs =
                                  await SharedPreferences.getInstance();
                              String formattedRole = _role.contains("Company")
                                  ? "company"
                                  : "candidate";

                              await prefs.setString("role", formattedRole);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? "),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),

                if (isWide)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "/mnt/data/5846f9bb-00d5-44fd-91b2-9e70fe4facdf.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String t) => Text(
    t,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color(0xFF111827),
    ),
  );

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE5E7EB)),
    );
  }

  Widget _divider() => Container(height: 1, color: const Color(0xFFE5E7EB));

  Widget _field({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    TextInputType? keyboard,
    Widget? suffix,
  }) {
    return Container(
      decoration: _boxDecoration(),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          suffixIcon: suffix,
        ),
      ),
    );
  }

  Widget _socialButton({
    required Widget icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return Container(
      height: 56,
      decoration: _boxDecoration(),
      child: TextButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
