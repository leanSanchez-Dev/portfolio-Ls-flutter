import 'package:flutter/material.dart';
import 'package:portfolio_ls/utils/theme_data.dart';

/// Compact PWA dashboard mock: hours, PDF actas, Supabase sync.
class FundacerPwaPreview extends StatelessWidget {
  const FundacerPwaPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B1220), Color(0xFF101626), Color(0xFF1E1B4B)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            top: -24,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981).withValues(alpha: 0.2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xF20D111A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF34D399),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'FUNDASER · PWA',
                          style: AppFonts.mono(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color(0xFF10B981).withValues(alpha: 0.35),
                            ),
                          ),
                          child: Text(
                            '● Synced',
                            style: AppFonts.mono(
                              fontSize: 10,
                              color: const Color(0xFF6EE7B7),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _Metric(
                              label: 'HORAS MES',
                              value: '168.5h',
                              footer: _ProgressBar(value: 0.82),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: _Metric(
                              label: 'ACTAS PDF',
                              value: '24 / 24',
                              valueColor: Color(0xFFA5B4FC),
                              footerText: '100% Firmado',
                              footerColor: Color(0xFF34D399),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: _Metric(
                              label: 'ESTADO',
                              value: 'Aprobado',
                              valueColor: Color(0xFF34D399),
                              footerText: 'Supabase RLS',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Informe_Gestion_Nov.pdf',
                              style: AppFonts.mono(
                                fontSize: 10,
                                color: const Color(0xFFCBD5E1),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'Verificado ✓',
                            style: AppFonts.mono(
                              fontSize: 10,
                              color: const Color(0xFF818CF8),
                            ),
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

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    this.valueColor = Colors.white,
    this.footer,
    this.footerText,
    this.footerColor = const Color(0xFF94A3B8),
  });

  final String label;
  final String value;
  final Color valueColor;
  final Widget? footer;
  final String? footerText;
  final Color footerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppFonts.mono(fontSize: 9, color: const Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppFonts.mono(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
          const Spacer(),
          if (footer != null) footer!,
          if (footerText != null)
            Text(
              footerText!,
              style: AppFonts.mono(fontSize: 9, color: footerColor),
            ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 4,
        backgroundColor: Colors.white12,
        color: const Color(0xFF34D399),
      ),
    );
  }
}
