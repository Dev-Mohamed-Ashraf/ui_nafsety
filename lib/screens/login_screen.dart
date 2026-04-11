import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../routes/app_routes.dart';
import '../widgets/auth_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF008657),
      body: Column(
        children: [
          const AuthTopBar(),
          Expanded(
            child: _AuthCard(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _AuthHeading(
                      title: 'Welcome Back',
                      subtitle: 'Ready to continue your learning journey?',
                      boldSuffix: 'Your path is right here.',
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter email',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const PasswordField(),
                    const SizedBox(height: 12),
                    const _RememberMeRow(),
                    const SizedBox(height: 28),
                    AuthPrimaryButton(
                      label: 'Log In',
                      onPressed: () => Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.home,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const AuthDivider(label: 'Sign in with'),
                    const SizedBox(height: 20),
                    const GoogleSignInButton(),
                    const SizedBox(height: 28),
                    _AuthFooterLink(
                      question: "Don't have an account? ",
                      linkText: 'Sign up',
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.signup,
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

class _AuthCard extends StatelessWidget {
  final Widget child;

  const _AuthCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF0F4F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: child,
    );
  }
}

class _AuthHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  final String boldSuffix;

  const _AuthHeading({
    required this.title,
    required this.subtitle,
    required this.boldSuffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            children: [
              TextSpan(text: '$subtitle\n'),
              TextSpan(
                text: boldSuffix,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RememberMeRow extends StatelessWidget {
  const _RememberMeRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: true,
                activeColor: const Color(0xFFE04343),
                checkColor: Colors.white,
                side: const BorderSide(color: Color(0xFFE04343)),
                onChanged: null,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'Remember me',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
        TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Forget password?',
            style: TextStyle(fontSize: 12, color: Color(0xFFE04343)),
          ),
        ),
      ],
    );
  }
}

class _AuthFooterLink extends StatelessWidget {
  final String question;
  final String linkText;
  final VoidCallback onTap;

  const _AuthFooterLink({
    required this.question,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE04343),
            ),
          ),
        ),
      ],
    );
  }
}
