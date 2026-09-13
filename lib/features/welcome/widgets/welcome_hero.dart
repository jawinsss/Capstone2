import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Hero carousel with gradient card, floating feature chips, and page indicator
class WelcomeHero extends StatefulWidget {
  const WelcomeHero({super.key});

  @override
  State<WelcomeHero> createState() => _WelcomeHeroState();
}

class _WelcomeHeroState extends State<WelcomeHero> {
  int _currentPage = 0;

  final List<_HeroSlide> _slides = const [
    _HeroSlide(
      centerIcon: Icons.auto_fix_high_rounded,
      centerLabel: 'AI Scoring',
      gradientStart: AppColors.heroGradientStart,
      gradientEnd: AppColors.heroGradientEnd,
      topLeftChip: _ChipData(
        icon: Icons.brush_rounded,
        color: AppColors.chipGreen,
        label: 'AI Stroke Suggestion',
      ),
      topRightChip: _ChipData(
        icon: Icons.menu_book_rounded,
        color: AppColors.chipBlue,
        label: '100+ Lessons',
      ),
      bottomLeftChip: _ChipData(
        icon: Icons.gesture_rounded,
        color: AppColors.chipGreen,
        label: 'Practice',
      ),
      bottomRightChip: _ChipData(
        icon: Icons.trending_up_rounded,
        color: AppColors.chipBlue,
        label: 'Improvement',
      ),
      caption: 'AI-powered drawing practice & step-by-step guidance',
    ),
    _HeroSlide(
      centerIcon: Icons.school_rounded,
      centerLabel: 'AI Lessons',
      gradientStart: Color(0xFFE8F4FF),
      gradientEnd: Color(0xFFF0FFE8),
      topLeftChip: _ChipData(
        icon: Icons.star_rounded,
        color: AppColors.chipPurple,
        label: 'Draw from scratch',
      ),
      topRightChip: _ChipData(
        icon: Icons.videocam_rounded,
        color: AppColors.chipGreen,
        label: 'Video tutorials',
      ),
      bottomLeftChip: _ChipData(
        icon: Icons.lightbulb_rounded,
        color: AppColors.chipBlue,
        label: 'Smart suggestions',
      ),
      bottomRightChip: _ChipData(
        icon: Icons.emoji_events_rounded,
        color: AppColors.primary,
        label: 'Daily achievements',
      ),
      caption: 'Smart drawing lessons with AI every day',
    ),
    _HeroSlide(
      centerIcon: Icons.insights_rounded,
      centerLabel: 'Improvement',
      gradientStart: Color(0xFFF3E8FF),
      gradientEnd: Color(0xFFFFE8F0),
      topLeftChip: _ChipData(
        icon: Icons.bar_chart_rounded,
        color: AppColors.chipPurple,
        label: 'Progress tracking',
      ),
      topRightChip: _ChipData(
        icon: Icons.military_tech_rounded,
        color: AppColors.primary,
        label: 'Skill badges',
      ),
      bottomLeftChip: _ChipData(
        icon: Icons.calendar_today_rounded,
        color: AppColors.chipBlue,
        label: 'Daily practice',
      ),
      bottomRightChip: _ChipData(
        icon: Icons.auto_awesome_rounded,
        color: AppColors.chipGreen,
        label: 'Stroke analysis',
      ),
      caption: 'Track progress & develop drawing skills',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardHeight = screenWidth < 360 ? 200.0 : 230.0;

    return Column(
      children: [
        // ── Carousel ────────────────────────────────────────────────────
        SizedBox(
          height: cardHeight + 16,
          child: PageView.builder(
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _HeroCard(slide: _slides[index], height: cardHeight),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // ── Caption ──────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            _slides[_currentPage].caption,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // ── Page indicator ───────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_slides.length, (i) {
            final isActive = i == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? AppColors.dotActive : AppColors.dotInactive,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),

        const SizedBox(height: 10),

        // ── Swipe hint ───────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chevron_left_rounded,
              size: 18,
              color: Colors.grey.shade400,
            ),
            const SizedBox(width: 6),
            Text('SWIPE TO DISCOVER', style: AppTextStyles.carouselHint),
            const SizedBox(width: 6),
            Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ],
    );
  }
}

// ── Data model ─────────────────────────────────────────────────────────────

class _ChipData {
  final IconData icon;
  final Color color;
  final String label;
  const _ChipData({
    required this.icon,
    required this.color,
    required this.label,
  });
}

class _HeroSlide {
  final IconData centerIcon;
  final String centerLabel;
  final Color gradientStart;
  final Color gradientEnd;
  final _ChipData topLeftChip;
  final _ChipData topRightChip;
  final _ChipData bottomLeftChip;
  final _ChipData bottomRightChip;
  final String caption;
  const _HeroSlide({
    required this.centerIcon,
    required this.centerLabel,
    required this.gradientStart,
    required this.gradientEnd,
    required this.topLeftChip,
    required this.topRightChip,
    required this.bottomLeftChip,
    required this.bottomRightChip,
    required this.caption,
  });
}

// ── Hero card widget ───────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  final _HeroSlide slide;
  final double height;
  const _HeroCard({required this.slide, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [slide.gradientStart, slide.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: slide.gradientStart.withValues(alpha: 0.5),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center circular icon
          _CenterCircle(icon: slide.centerIcon, label: slide.centerLabel),

          // Top-left chip
          Positioned(
            top: 20,
            left: 12,
            child: _FloatingChip(data: slide.topLeftChip),
          ),

          // Top-right chip
          Positioned(
            top: 20,
            right: 12,
            child: _FloatingChip(data: slide.topRightChip),
          ),

          // Bottom-left chip
          Positioned(
            bottom: 20,
            left: 12,
            child: _FloatingChip(data: slide.bottomLeftChip),
          ),

          // Bottom-right chip
          Positioned(
            bottom: 20,
            right: 12,
            child: _FloatingChip(data: slide.bottomRightChip),
          ),
        ],
      ),
    );
  }
}

class _CenterCircle extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CenterCircle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Outer ring
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.ringOuter.withValues(alpha: 0.5),
          ),
          child: Center(
            // Inner ring
            child: Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.ringInner,
              ),
              child: Icon(icon, color: AppColors.primary, size: 32),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _FloatingChip extends StatelessWidget {
  final _ChipData data;
  const _FloatingChip({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.icon, color: data.color, size: 14),
          const SizedBox(width: 5),
          Text(data.label, style: AppTextStyles.chipLabel),
        ],
      ),
    );
  }
}
