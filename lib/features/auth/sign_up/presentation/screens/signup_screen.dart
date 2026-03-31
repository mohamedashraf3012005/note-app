import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/on_boarding/presentation/widgets/contact_button.dart';
import 'package:task2/features/on_boarding/presentation/widgets/login_button.dart';
import 'package:task2/features/on_boarding/presentation/widgets/on_boarding_header.dart';
import 'package:task2/features/on_boarding/presentation/widgets/text_input.dart';
import 'package:task2/features/auth/sign_in/presentation/screens/login_screen.dart';
import 'package:task2/features/auth/sign_up/presentation/cubit/signup_cubit.dart';
import 'package:task2/features/auth/sign_up/presentation/cubit/signup_state.dart';
import 'package:task2/features/note/presentation/screens/my_folders_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool agreeToPolicy = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Account created successfully!"),
                duration: Duration(seconds: 4),
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyFoldersPage()),
              (route) => false,
            );
            // ......
          } else if (state is SignupError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignupCubit>();
          final isLoading = state is SignupLoading;

          return Scaffold(
            backgroundColor: const Color(0xFFEEF3F9),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const OnboardingHeader(
                      title: "Sign Up",
                      subtitle:
                          "Create an account or log in to explore our app",
                    ),
                    const SizedBox(height: 32),
                    TextInput(
                      title: 'Name',
                      hintText: 'Enter your name',
                      obscureText: false,
                      suffixIcon: const Icon(Icons.person),
                      controller: nameController,
                    ),
                    const SizedBox(height: 16),
                    TextInput(
                      title: 'Email',
                      hintText: 'Enter your email',
                      obscureText: false,
                      suffixIcon: const Icon(Icons.email),
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    TextInput(
                      title: 'Password',
                      hintText: 'Enter your password',
                      obscureText: true,
                      controller: passwordController,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: const Color(0xFF4A90E2),
                            value: agreeToPolicy,
                            onChanged: (value) {
                              setState(() => agreeToPolicy = value ?? false);
                            },
                          ),
                          const Expanded(
                            child: Text(
                              "I agree with privacy and policy",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    LoginButton(
                      title: isLoading ? "جاري إنشاء الحساب..." : "Sign Up",
                      onPressed: isLoading
                          ? null
                          : () => cubit.signup(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                            ),
                    ),

                    const SizedBox(height: 24),
                    const Text(
                      '__________________________  Or  __________________________',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ContactButton(
                          title: "Google",
                          imagePath: "assets/images/google.png",
                        ),
                        SizedBox(width: 24),
                        ContactButton(
                          title: "Facebook",
                          imagePath: "assets/images/facebook.png",
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Log In",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
