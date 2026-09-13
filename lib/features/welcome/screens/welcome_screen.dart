import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../auth/screens/login_screen.dart';
import '../../auth/screens/register_screen.dart';
import '../widgets/welcome_feature_card.dart';
import '../widgets/welcome_guest_button.dart';
import '../widgets/welcome_header.dart';
import '../widgets/welcome_hero.dart';
import '../widgets/welcome_login_button.dart';
import '../widgets/welcome_primary_button.dart';

/// Main welcome / onboarding screen for Draw Easy
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive horizontal padding
    final double hPad = screenWidth > 600 ? screenWidth * 0.12 : 20.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── 1. Header ──────────────────────────────────────────────
              const WelcomeHeader(),

              const SizedBox(height: 4),

              // ── 2. Hero carousel ───────────────────────────────────────
              const WelcomeHero(),

              const SizedBox(height: 28),

              // ── 3. Title + description ─────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Draw Easy: AI Drawing Practice',
                      style: AppTextStyles.h1,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'An AI-assisted mobile application for drawing '
                      'practice and skill development. AI drawing assistant '
                      'with step-by-step sketching guidance.',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── 4. Feature cards row ───────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // On very narrow screens stack cards vertically
                    if (constraints.maxWidth < 280) {
                      return Column(
                        children: _featureCards()
                            .map(
                              (c) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(children: [c]),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _featureCardsWithGaps(),
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              // ── 5. Primary CTA → RegisterScreen ────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: WelcomePrimaryButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ── 6. Login row → LoginScreen ─────────────────────────────
              WelcomeLoginButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),

              const SizedBox(height: 8),

              // ── 7. Guest button (guest mode – future) ──────────────────
              WelcomeGuestButton(
                onPressed: () {
                  // TODO: navigate to guest mode
                },
              ),

              const SizedBox(height: 16),

              // ── 8. Footer disclaimer ───────────────────────────────────
              _Footer(hPad: hPad),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  List<WelcomeFeatureCard> _featureCards() => const [
    WelcomeFeatureCard(
      icon: Icons.auto_fix_high_rounded,
      iconBg: AppColors.iconBgPink,
      iconColor: AppColors.primary,
      title: 'AI Sketching',
      subtitle: 'Smart Suggestions',
    ),
    WelcomeFeatureCard(
      icon: Icons.calendar_today_rounded,
      iconBg: AppColors.iconBgGreen,
      iconColor: Color(0xFF10B981),
      title: 'Practice Everyday',
      subtitle: 'Beginner - Advanced',
    ),
    WelcomeFeatureCard(
      icon: Icons.trending_up_rounded,
      iconBg: AppColors.iconBgPurple,
      iconColor: Color(0xFF8B5CF6),
      title: 'Visible Improvement',
      subtitle: 'Skill Development',
    ),
  ];

  List<Widget> _featureCardsWithGaps() {
    final cards = _featureCards();
    final List<Widget> result = [];
    for (int i = 0; i < cards.length; i++) {
      result.add(cards[i]);
      if (i < cards.length - 1) result.add(const SizedBox(width: 10));
    }
    return result;
  }
}

// ── Footer ─────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  final double hPad;
  const _Footer({required this.hPad});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Column(
        children: [
          Text(
            'By continuing, you agree to the ',
            textAlign: TextAlign.center,
            style: AppTextStyles.footerSmall,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: AppTextStyles.footerLink,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(text: ' & ', style: AppTextStyles.footerSmall),
                TextSpan(
                  text: 'Privacy Policy',
                  style: AppTextStyles.footerLink,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text: ' of Draw Easy.',
                  style: AppTextStyles.footerSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
