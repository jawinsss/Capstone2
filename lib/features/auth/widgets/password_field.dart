import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Password field with visibility toggle + optional strength bar
class PasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final bool showStrengthBar;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const PasswordField({
    super.key,
    this.label = 'Password',
    this.hint = 'At least 8 characters',
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.showStrengthBar = false,
    this.validator,
    this.onChanged,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;
  int _strength = 0; // 0-4

  void _onChanged(String value) {
    widget.onChanged?.call(value);
    if (widget.showStrengthBar) {
      setState(() => _strength = _calcStrength(value));
    }
  }

  int _calcStrength(String pwd) {
    if (pwd.isEmpty) return 0;
    int score = 0;
    if (pwd.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(pwd)) score++;
    if (RegExp(r'[0-9]').hasMatch(pwd)) score++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(pwd)) score++;
    return score;
  }

  Color _barColor(int index) {
    if (index >= _strength) return AppColors.strengthEmpty;
    if (_strength == 1) return AppColors.strengthWeak;
    if (_strength == 2) return AppColors.strengthFair;
    if (_strength == 3) return AppColors.strengthGood;
    return AppColors.strengthStrong;
  }

  String _strengthLabel() {
    switch (_strength) {
      case 0:
        return 'Not entered';
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      default:
        return 'Strong';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),

        // Input
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          textInputAction: widget.textInputAction,
          onChanged: _onChanged,
          validator: widget.validator,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 15,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 15,
              color: AppColors.textHint,
            ),
            prefixIcon: const Icon(Icons.lock_outline_rounded,
                color: AppColors.textHint, size: 20),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textHint,
                size: 20,
              ),
            ),
            filled: true,
            fillColor: AppColors.fieldFill,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: AppColors.fieldBorder, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: AppColors.fieldFocusBorder, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: AppColors.strengthWeak, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: AppColors.strengthWeak, width: 2),
            ),
            border: InputBorder.none,
          ),
        ),

        // Strength bar (only on register)
        if (widget.showStrengthBar) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Password strength',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 11,
                  color: AppColors.textHint,
                ),
              ),
              const Spacer(),
              Text(
                _strengthLabel(),
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _strength == 0
                      ? AppColors.textHint
                      : _barColor(_strength - 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(4, (i) {
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 4,
                  margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                  decoration: BoxDecoration(
                    color: _barColor(i),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}
