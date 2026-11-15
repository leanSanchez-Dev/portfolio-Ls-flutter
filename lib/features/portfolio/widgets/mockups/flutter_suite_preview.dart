import 'package:flutter/material.dart';
import 'package:portfolio_ls/utils/theme_data.dart';

/// Dual device-frame mock: offline queue SQLite/FCM + 60 FPS telemetry.
class FlutterSuitePreview extends StatelessWidget {
  const FlutterSuitePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B192C), Color(0xFF101C33), Color(0xFF022C22)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 28,
            top: 18,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF38BDF8).withValues(alpha: 0.2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0F1A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(
                                'FLUTTER · BLoC',
                                style: AppFonts.mono(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF38BDF8),
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
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4F46E5), Color(0xFF0EA5E9)],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'OFFLINE QUEUE',
                                  style: AppFonts.mono(
                                    fontSize: 9,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  '0 Pendientes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          _RowStat(label: 'SQLite Local', value: 'OK', valueColor: const Color(0xFF34D399)),
                          const SizedBox(height: 6),
                          _RowStat(label: 'FCM Push', value: 'Activo', valueColor: const Color(0xFF38BDF8)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 120,
                  height: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '60 FPS UI',
                        style: AppFonts.mono(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF6EE7B7),
                        ),
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: const LinearProgressIndicator(
                          value: 0.92,
                          minHeight: 6,
                          backgroundColor: Colors.white12,
                          color: Color(0xFF38BDF8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: const LinearProgressIndicator(
                          value: 0.8,
                          minHeight: 6,
                          backgroundColor: Colors.white12,
                          color: Color(0xFF34D399),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'iOS + Android\nSingle Codebase',
                        style: AppFonts.mono(
                          fontSize: 9,
                          color: const Color(0xFFCBD5E1),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RowStat extends StatelessWidget {
  const _RowStat({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppFonts.mono(fontSize: 9, color: const Color(0xFFE2E8F0)),
            ),
          ),
          Text(
            value,
            style: AppFonts.mono(fontSize: 9, color: valueColor),
          ),
        ],
      ),
    );
  }
}
