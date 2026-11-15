import 'package:flutter/material.dart';
import 'package:portfolio_ls/utils/theme_data.dart';

/// Mini Angular workspace mock with CustomPainter sparkline (-42% TTI).
class AngularEnterprisePreview extends StatelessWidget {
  const AngularEnterprisePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF121024), Color(0xFF16192B), Color(0xFF0F172A)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6366F1).withValues(alpha: 0.25),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xF20D101B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF818CF8).withValues(alpha: 0.45),
                              ),
                            ),
                            child: Text(
                              'Ng',
                              style: AppFonts.mono(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFA5B4FC),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 18,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF818CF8),
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 14,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 14,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Color(0xFF34D399),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'CoreDesignSystem · v18',
                                  style: AppFonts.mono(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6366F1)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'RxJS Signals',
                                  style: AppFonts.mono(
                                    fontSize: 9,
                                    color: const Color(0xFFA5B4FC),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.03),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'BUNDLE LAZY-LOAD',
                                        style: AppFonts.mono(
                                          fontSize: 9,
                                          color: const Color(0xFF94A3B8),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '-42% TTI',
                                        style: AppFonts.mono(
                                          fontSize: 9,
                                          color: const Color(0xFF34D399),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Expanded(
                                    child: CustomPaint(
                                      painter: _SparklinePainter(),
                                      child: const SizedBox.expand(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _Stat(label: 'Módulos', value: '18'),
                              ),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: _Stat(
                                  label: 'API Java',
                                  value: '48ms',
                                  valueColor: Color(0xFF34D399),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    this.valueColor = Colors.white,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: AppFonts.mono(fontSize: 10, color: const Color(0xFFCBD5E1)),
          ),
          const Spacer(),
          Text(
            value,
            style: AppFonts.mono(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.78)
      ..cubicTo(
        size.width * 0.14,
        size.height * 0.7,
        size.width * 0.23,
        size.height * 0.3,
        size.width * 0.39,
        size.height * 0.42,
      )
      ..cubicTo(
        size.width * 0.55,
        size.height * 0.55,
        size.width * 0.66,
        size.height * 0.14,
        size.width * 0.82,
        size.height * 0.22,
      )
      ..cubicTo(
        size.width * 0.9,
        size.height * 0.26,
        size.width * 0.95,
        size.height * 0.1,
        size.width,
        size.height * 0.06,
      );

    final fill = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF6366F1).withValues(alpha: 0.45),
          const Color(0xFF6366F1).withValues(alpha: 0),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawPath(fill, fillPaint);
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF818CF8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
