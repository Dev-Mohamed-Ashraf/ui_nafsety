import 'package:flutter/material.dart';
import 'package:nafsety/screens/login_screen.dart';
import 'package:nafsety/screens/onboarding_screen.dart';
import 'package:nafsety/screens/signup_screen.dart';
import 'package:nafsety/screens/splash_screen.dart';
import 'package:nafsety/screens/welcome_screen.dart';
import '../screens/home_screen.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home'; 

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    welcome: (_) => const WelcomeScreen(),
    login: (_) => const LoginScreen(),
    signup: (_) => const SignupScreen(),
    home: (_) => const MainShellScreen(), 
  };
}
