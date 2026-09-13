import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/password_field.dart';

/// Reset Password screen – set a new password after clicking the email link
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _isLoading = false;
  bool _success = false;

  @override
  void dispose() {
    _newPasswordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: call AuthService.confirmPasswordReset(newPassword)
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _success = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final hPad = screenWidth > 600 ? screenWidth * 0.12 : 24.0;

    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: _success
              ? _SuccessView(
                  onContinue: () {
                    // TODO: Navigate to LoginScreen
                  },
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // ── Back ─────────────────────────────────────────
                      _CircleBackBtn(onTap: () => Navigator.maybePop(context)),

                      const SizedBox(height: 32),

                      // ── Illustration ─────────────────────────────────
                      Center(child: _ResetIllustration()),

                      const SizedBox(height: 32),

                      // ── Title ─────────────────────────────────────────
                      const Text(
                        'Create New Password ',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your new password must be different from\nyour previously used password.',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── Requirements card ─────────────────────────────
                      _RequirementsCard(),

                      const SizedBox(height: 24),

                      // ── New password ──────────────────────────────────
                      PasswordField(
                        label: 'New Password',
                        hint: 'At least 8 characters',
                        controller: _newPasswordCtrl,
                        showStrengthBar: true,
                        validator: (v) {
                          if (v == null || v.length < 8) {
                            return 'Must be at least 8 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // ── Confirm ───────────────────────────────────────
                      PasswordField(
                        label: 'Confirm New Password',
                        hint: 'Re-enter your new password',
                        controller: _confirmCtrl,
                        textInputAction: TextInputAction.done,
                        validator: (v) {
                          if (v != _newPasswordCtrl.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 28),

                      // ── Submit ────────────────────────────────────────
                      AuthPrimaryButton(
                        label: 'Reset Password',
                        trailingIcon: Icons.lock_reset_rounded,
                        onPressed: _submit,
                        isLoading: _isLoading,
                      ),

                      const SizedBox(height: 20),

                      // ── Back to login ─────────────────────────────────
                      Center(
                        child: TextButton.icon(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          label: const Text(
                            'Back to Sign In',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

class _CircleBackBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _CircleBackBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          size: 18,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _ResetIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEEF4FF), Color(0xFFFFF0E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.chipPurple.withValues(alpha: 0.1),
            ),
          ),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.chipPurple.withValues(alpha: 0.15),
            ),
            child: const Icon(
              Icons.shield_rounded,
              size: 36,
              color: AppColors.chipPurple,
            ),
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.successGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 13,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequirementsCard extends StatelessWidget {
  final List<_Req> _reqs = const [
    _Req(label: 'At least 8 characters'),
    _Req(label: 'One uppercase letter (A–Z)'),
    _Req(label: 'One number (0–9)'),
    _Req(label: 'One special character (!@#\$...)'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.infoBlueBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.infoBlue.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.infoBlue,
                size: 16,
              ),
              SizedBox(width: 6),
              Text(
                'Password requirements',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ..._reqs.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 5, color: AppColors.infoBlue),
                  const SizedBox(width: 8),
                  Text(
                    r.label,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Req {
  final String label;
  const _Req({required this.label});
}

/// Full success view shown after password reset
class _SuccessView extends StatelessWidget {
  final VoidCallback onContinue;
  const _SuccessView({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final hPad = 0.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),

          // Success circle
          Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 72,
              color: AppColors.successGreen,
            ),
          ),

          const SizedBox(height: 32),

          const Text(
            'Password Reset! 🎉',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Your password has been successfully reset.\nYou can now sign in with your new password.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 40),

          AuthPrimaryButton(
            label: 'Continue to Sign In',
            trailingIcon: Icons.arrow_forward_rounded,
            onPressed: onContinue,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
