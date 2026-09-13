import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Google + Apple social sign-in buttons row
class SocialLogin extends StatelessWidget {
  final String actionLabel; // 'Sign up' or 'Sign in'
  const SocialLogin({super.key, this.actionLabel = 'Sign up'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Google
        _SocialBtn(
          onTap: () {},
          backgroundColor: AppColors.googleBtnBg,
          borderColor: AppColors.fieldBorder,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google 'G' painted manually
              _GoogleLogo(),
              const SizedBox(width: 10),
              Text(
                '$actionLabel with Google',
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Apple
        _SocialBtn(
          onTap: () {},
          backgroundColor: AppColors.appleBtnBg,
          borderColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.apple_rounded, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Text(
                '$actionLabel with Apple',
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Widget child;
  const _SocialBtn({
    required this.onTap,
    required this.backgroundColor,
    required this.borderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1.2),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Minimal Google "G" logo using a CustomPainter
class _GoogleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(20, 20),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    // Red arc (top-right)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r),
      -1.05, 1.57, false,
      Paint()
        ..color = const Color(0xFFEA4335)
        ..strokeWidth = size.width * 0.17
        ..style = PaintingStyle.stroke,
    );
    // Blue arc (left)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r),
      2.09, 1.83, false,
      Paint()
        ..color = const Color(0xFF4285F4)
        ..strokeWidth = size.width * 0.17
        ..style = PaintingStyle.stroke,
    );
    // Yellow arc (bottom)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r),
      0.52, 1.57, false,
      Paint()
        ..color = const Color(0xFFFBBC05)
        ..strokeWidth = size.width * 0.17
        ..style = PaintingStyle.stroke,
    );
    // Green arc (bottom-right)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r),
      -0.52, 1.04, false,
      Paint()
        ..color = const Color(0xFF34A853)
        ..strokeWidth = size.width * 0.17
        ..style = PaintingStyle.stroke,
    );

    // Horizontal bar of G
    final paint = Paint()
      ..color = const Color(0xFF4285F4)
      ..strokeWidth = size.width * 0.17
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(center.dx, center.dy),
      Offset(size.width, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
