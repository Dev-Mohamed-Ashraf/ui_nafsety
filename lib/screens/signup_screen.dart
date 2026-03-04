import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../widgets/auth_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onGetStarted() =>
      Navigator.pushReplacementNamed(context, AppRoutes.home);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF008657),
      body: Column(
        children: [
          const AuthTopBar(),
          Expanded(
            child: AuthCard(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AuthHeading(
                      title: 'Create Your Account',
                      subtitle:
                          "We're here to help you reach the peaks of learning.",
                      boldSuffix: 'Are you ready?',
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: 'Enter full name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter email',
                      ),
                    ),
                    const SizedBox(height: 16),
                    PasswordField(controller: _passwordController),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Forget password?',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFE04343),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AuthPrimaryButton(
                      label: 'Get Started',
                      onPressed: _onGetStarted,
                    ),
                    const SizedBox(height: 28),
                    const AuthDivider(label: 'Sign up with'),
                    const SizedBox(height: 20),
                    const GoogleSignInButton(),
                    const SizedBox(height: 28),
                    AuthFooterLink(
                      question: 'Already have an account? ',
                      linkText: 'Log in',
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.login,
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
}
