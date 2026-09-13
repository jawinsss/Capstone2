import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Shared auth top-bar: back arrow · logo+title · help & avatar icons
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Back button
          _CircleBtn(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.maybePop(context),
          ),

          const SizedBox(width: 10),

          // Logo + title
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/logo/logo draw esay.jpeg',
              width: 26,
              height: 26,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.brush_rounded,
                    color: Colors.white, size: 14),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Create Account',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),

          const Spacer(),

          // Help icon
          _CircleBtn(icon: Icons.help_outline_rounded, onTap: () {}),
          const SizedBox(width: 8),

          // Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_rounded,
                color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}
