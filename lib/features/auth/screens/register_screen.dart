import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_field.dart';
import '../widgets/security_info_card.dart';
import '../widgets/social_login.dart';
import '../widgets/term_checkbox.dart';
import 'login_screen.dart';

/// Register / Create Account screen
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _agreed = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms of Service.'),
          backgroundColor: AppColors.strengthWeak,
        ),
      );
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: call AuthService.register(name, email, password)
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final hPad = screenWidth > 600 ? screenWidth * 0.12 : 20.0;

    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AuthHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Journey badge ──────────────────────────────────
                      _JourneyBadge(label: 'Start your journey'),

                      const SizedBox(height: 12),

                      // ── Title ──────────────────────────────────────────
                      const Text(
                        'Create Account ',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Start practicing and mastering your drawing\nskills with Draw Easy AI.',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ── Social ─────────────────────────────────────────
                      const SocialLogin(actionLabel: 'Sign up'),

                      const SizedBox(height: 20),

                      // ── Divider ────────────────────────────────────────
                      const _OrDivider(label: 'or sign up with Email'),

                      const SizedBox(height: 20),

                      // ── Full name ──────────────────────────────────────
                      AuthTextField(
                        label: 'Full Name',
                        hint: 'Alex Morgan',
                        prefixIcon: Icons.person_outline_rounded,
                        controller: _nameCtrl,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Enter your name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // ── Email ──────────────────────────────────────────
                      AuthTextField(
                        label: 'Email Address',
                        hint: 'alex@example.com',
                        prefixIcon: Icons.alternate_email_rounded,
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Enter your email';
                          }
                          if (!v.contains('@')) return 'Invalid email';
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // ── Password ───────────────────────────────────────
                      PasswordField(
                        label: 'Password',
                        hint: 'At least 8 characters',
                        controller: _passwordCtrl,
                        showStrengthBar: true,
                        validator: (v) {
                          if (v == null || v.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // ── Confirm password ───────────────────────────────
                      PasswordField(
                        label: 'Confirm Password',
                        hint: 'Re-enter your password',
                        controller: _confirmCtrl,
                        textInputAction: TextInputAction.done,
                        validator: (v) {
                          if (v != _passwordCtrl.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // ── Terms checkbox ─────────────────────────────────
                      TermCheckbox(
                        onChanged: (v) => setState(() => _agreed = v),
                      ),

                      const SizedBox(height: 24),

                      // ── Submit ─────────────────────────────────────────
                      AuthPrimaryButton(
                        label: 'Create Account',
                        onPressed: _submit,
                        isLoading: _isLoading,
                      ),

                      const SizedBox(height: 20),

                      // ── Login redirect ─────────────────────────────────
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              const TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                text: 'Sign In',
                                style: const TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ── Security card ──────────────────────────────────
                      const SecurityInfoCard(),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared sub-widgets (same as login_screen.dart) ─────────────────────────

class _JourneyBadge extends StatelessWidget {
  final String label;
  const _JourneyBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.journeyBadgeBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.auto_awesome_rounded,
            size: 14,
            color: AppColors.journeyBadgeText,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.journeyBadgeText,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  final String label;
  const _OrDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.dividerColor, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 12,
              color: AppColors.textHint,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.dividerColor, thickness: 1),
        ),
      ],
    );
  }
}
