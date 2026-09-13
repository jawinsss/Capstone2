import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// "Dùng thử với tư cách Khách " ghost button
class WelcomeGuestButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const WelcomeGuestButton({super.key, this.onPressed});

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
            Text(
              'Try as Guest',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.open_in_new_rounded,
              size: 13,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
