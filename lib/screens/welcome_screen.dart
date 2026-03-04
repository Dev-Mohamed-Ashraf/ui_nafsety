import 'package:flutter/material.dart';

import '../theme/app_assets.dart';
import '../routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              const _WelcomeHeader(),
              const SizedBox(height: 24),
              const _WelcomeIllustration(),
              const Spacer(),
              _WelcomeButton(
                label: 'Create Account',
                onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
                isPrimary: true,
              ),
              const SizedBox(height: 14),
              _WelcomeButton(
                label: 'Log In',
                onTap: () => Navigator.pushNamed(context, AppRoutes.login),
                isPrimary: false,
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Welcome <3',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF8A7774),
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8A7774),
              height: 1.6,
            ),
            children: [
              TextSpan(
                text:
                    "Hi there!\nwe're here to help you be better,\nthe choice is yours: ",
              ),
              TextSpan(
                text: 'Log In',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: ' or '),
              TextSpan(
                text: 'create an account.',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WelcomeIllustration extends StatelessWidget {
  const _WelcomeIllustration();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.screenWelcome,
      width: MediaQuery.of(context).size.width * 0.82,
      fit: BoxFit.contain,
    );
  }
}

class _WelcomeButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _WelcomeButton({
    required this.label,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isPrimary
          ? ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF008657),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE2D696),
                foregroundColor: const Color(0xFF1A1A2E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
    );
  }
}
