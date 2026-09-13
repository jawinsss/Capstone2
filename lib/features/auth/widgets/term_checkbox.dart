import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// "I agree to the Terms of Service and Privacy Policy" checkbox row
class TermCheckbox extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  const TermCheckbox({super.key, this.onChanged});

  @override
  State<TermCheckbox> createState() => _TermCheckboxState();
}

class _TermCheckboxState extends State<TermCheckbox> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Custom checkbox
        GestureDetector(
          onTap: () {
            setState(() => _agreed = !_agreed);
            widget.onChanged?.call(_agreed);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: _agreed ? AppColors.checkboxActive : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _agreed ? AppColors.checkboxActive : AppColors.fieldBorder,
                width: 1.5,
              ),
            ),
            child: _agreed
                ? const Icon(Icons.check_rounded,
                    color: Colors.white, size: 15)
                : null,
          ),
        ),

        const SizedBox(width: 10),

        // Rich text
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
