import 'package:flutter/material.dart';
import 'package:task2/features/auth/sign_up/presentation/screens/signup_screen.dart';
import 'package:task2/features/on_boarding/presentation/widgets/connect_with_button.dart';
import 'package:task2/features/on_boarding/presentation/widgets/on_boarding_header.dart';
import 'package:task2/features/on_boarding/presentation/widgets/sign_up_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF3F9),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            OnboardingHeader(
              title: "Working Quest!",
              subtitle: "create an account to start \n your adventure",
            ),
            SizedBox(height: 20),
            Text("Swipe to learn more >"),
            SizedBox(height: 120),
            SignUpButton(
              title: 'Sign up with Apple',
              icon: Icons.apple,
              color: '0xFFFFFFFF',
              colorIcon: '0xFF000000',
            ),
            SizedBox(height: 20),
            SignUpButton(
              title: 'continue with your email',
              icon: Icons.email,
              color: '0xFFDCEBFE',
              colorIcon: '0xFF000000',
            ),
            SizedBox(height: 20),
            Text("Connect with"),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 25),
                ConnectWithButton(imagePath: 'assets/images/google.png'),
                SizedBox(width: 25),
                ConnectWithButton(imagePath: 'assets/images/facebook.png'),
                SizedBox(width: 25),
                ConnectWithButton(imagePath: 'assets/images/apple.png'),
              ],
            ),
            SizedBox(height: 40),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: Text("Sign up ", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
