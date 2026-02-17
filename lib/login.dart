import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

////////////////////////////////////////////////////////////
/// COMMON BLUE THEME COLORS
////////////////////////////////////////////////////////////

const primaryBlue = Color(0xff2979FF);
const darkBg = Color(0xff0B1220);
const cardBg = Color(0xff111827);

////////////////////////////////////////////////////////////
/// LOGIN SCREEN
////////////////////////////////////////////////////////////

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Stack(
        children: [

          const BlueRadialGlow(),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: GlassCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Welcome back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Sign in to your account",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 40),

                    buildField("Email"),

                    const SizedBox(height: 20),

                    buildField("Password", true),

                    const SizedBox(height: 32),

                    buildButton("Sign In"),

                    const SizedBox(height: 18),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField(String label, [bool isPassword = false]) {
    return TextField(
      obscureText: isPassword ? obscure : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryBlue, width: 1.4),
        ),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscure
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.white60,
          ),
          onPressed: () {
            setState(() {
              obscure = !obscure;
            });
          },
        )
            : null,
      ),
    );
  }

  Widget buildButton(String text) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// SIGNUP SCREEN
////////////////////////////////////////////////////////////

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: Stack(
        children: [

          const BlueRadialGlow(),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: GlassCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Create account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Start your journey",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 40),

                    buildField("Full Name"),
                    const SizedBox(height: 20),
                    buildField("Email"),
                    const SizedBox(height: 20),
                    buildField("Password", true),

                    const SizedBox(height: 32),

                    buildButton("Sign Up"),

                    const SizedBox(height: 18),

                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Already have an account? Sign in",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildField(String label, [bool isPassword = false]) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryBlue, width: 1.4),
        ),
      ),
    );
  }

  static Widget buildButton(String text) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// GLASS CARD
////////////////////////////////////////////////////////////

class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: primaryBlue.withOpacity(0.15),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// BLUE RADIAL GLOW BACKGROUND
////////////////////////////////////////////////////////////

class BlueRadialGlow extends StatelessWidget {
  const BlueRadialGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 1.3,
          colors: [
            Color(0xff14213D),
            Color(0xff0B1220),
          ],
        ),
      ),
    );
  }
}
