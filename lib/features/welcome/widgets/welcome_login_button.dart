import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// "Tôi đã có tài khoản • Đăng nhập" secondary row
class WelcomeLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const WelcomeLoginButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('I have an account', style: AppTextStyles.buttonSecondary),
            const SizedBox(width: 4),
            const Text(
              '•',
              style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 4),
            Text('Login', style: AppTextStyles.linkText),
          ],
        ),
      ),
    );
  }
}
