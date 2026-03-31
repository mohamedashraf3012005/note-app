import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/on_boarding/presentation/widgets/contact_button.dart';
import 'package:task2/features/on_boarding/presentation/widgets/login_button.dart';
import 'package:task2/features/on_boarding/presentation/widgets/on_boarding_header.dart';
import 'package:task2/features/on_boarding/presentation/widgets/text_input.dart';
import 'package:task2/features/auth/sign_in/presentation/cubit/login_cubit.dart';
import 'package:task2/features/auth/sign_in/presentation/cubit/login_state.dart';
import 'package:task2/features/auth/sign_up/presentation/screens/signup_screen.dart';
import 'package:task2/features/note/presentation/screens/my_folders_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login successful!")));
            
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyFoldersPage()),
              (route) => false,
            );
          } else if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          final isLoading = state is LoginLoading;

          return Scaffold(
            backgroundColor: const Color(0xFFEEF3F9),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const OnboardingHeader(
                      title: "Login",
                      subtitle: "Login to access your account",
                    ),
                    const SizedBox(height: 32),
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
                            value: rememberMe,
                            onChanged: (value) =>
                                setState(() => rememberMe = value ?? false),
                          ),
                          const Text(
                            "Remember Me",
                            style: TextStyle(color: Colors.black54),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    LoginButton(
                      title: isLoading ? "Logging in..." : "Log in",
                      onPressed: isLoading
                          ? null
                          : () => cubit.login(
                                email: emailController.text,
                                password: passwordController.text,
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
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
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
