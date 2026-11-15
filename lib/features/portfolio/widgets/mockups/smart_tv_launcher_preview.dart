import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio_ls/utils/theme_data.dart';

/// Liquid Glass Smart TV launcher mock — Monokai Pro + focus ring.
class SmartTvLauncherPreview extends StatelessWidget {
  const SmartTvLauncherPreview({super.key});

  static const _bg = Color(0xFF221F22);
  static const _pink = Color(0xFFFF6188);
  static const _yellow = Color(0xFFFFD866);
  static const _green = Color(0xFFA9DC76);
  static const _cyan = Color(0xFF78DCE8);
  static const _purple = Color(0xFFAB9DF2);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      color: _bg,
      child: Stack(
        children: [
          Positioned(
            left: -18,
            top: 8,
            child: _Orb(color: _pink.withValues(alpha: 0.28), size: 110),
          ),
          Positioned(
            right: 12,
            bottom: 4,
            child: _Orb(color: _cyan.withValues(alpha: 0.22), size: 120),
          ),
          Positioned(
            left: 120,
            top: 60,
            child: _Orb(color: _yellow.withValues(alpha: 0.16), size: 90),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.14),
                        Colors.white.withValues(alpha: 0.04),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: _yellow.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'OS // TV',
                                style: AppFonts.mono(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: _yellow,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Liquid Glass',
                              style: AppFonts.mono(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Wi-Fi 6',
                              style: AppFonts.mono(
                                fontSize: 10,
                                color: _cyan,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '21:45',
                              style: AppFonts.mono(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Row(
                            children: const [
                              Expanded(
                                child: _TvTile(
                                  color: _pink,
                                  label: 'Stream',
                                  focused: true,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _TvTile(color: _green, label: 'Arcade'),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _TvTile(color: _cyan, label: 'Music'),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _TvTile(color: _purple, label: 'Config'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Monokai Pro · D-Pad Focus Engine',
                              style: AppFonts.mono(
                                fontSize: 9,
                                color: Colors.white70,
                              ),
                            ),
                            const Spacer(),
                            const _Swatch(_pink),
                            const SizedBox(width: 4),
                            const _Swatch(_yellow),
                            const SizedBox(width: 4),
                            const _Swatch(_green),
                            const SizedBox(width: 4),
                            const _Swatch(_cyan),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

class _TvTile extends StatelessWidget {
  const _TvTile({
    required this.color,
    required this.label,
    this.focused = false,
  });

  final Color color;
  final String label;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: focused
            ? color.withValues(alpha: 0.25)
            : Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: focused ? SmartTvLauncherPreview._yellow : Colors.white24,
          width: focused ? 2 : 1,
        ),
        boxShadow: focused
            ? [
                BoxShadow(
                  color: SmartTvLauncherPreview._yellow.withValues(alpha: 0.25),
                  blurRadius: 12,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Spacer(),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.mono(
              fontSize: 9,
              fontWeight: focused ? FontWeight.w700 : FontWeight.w500,
              color: focused ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
