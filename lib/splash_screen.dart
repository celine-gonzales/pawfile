import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB), // warm cream/off-white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo in rounded square container
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFD6CBC0),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 70,
                  height: 70,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // App name — bold serif style
            const Text(
              'Pawfile',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Color(0xFF1A1A1A),
                fontFamily: 'Georgia', // fallback serif; swap for your chosen font
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            const Text(
              'The profile app made for pets.',
              style: TextStyle(
                color: Color(0xFF888888),
                fontSize: 13,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 28),

            // Short divider line
            Container(
              width: 36,
              height: 2,
              decoration: BoxDecoration(
                color: const Color(0xFFBBAFA6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 36),

            // Sign up button — teal/steel blue pill
            SizedBox(
              width: 220,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignupScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A7CA5), // teal-blue
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Login — plain text link
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A1A),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}