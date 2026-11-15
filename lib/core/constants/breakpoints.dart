/// Layout breakpoints for the Bento portfolio (ESD).
///
/// - mobile: width &lt; [mobile]
/// - tablet: [mobile] ≤ width &lt; [desktop]
/// - desktop: width ≥ [desktop]
abstract final class Breakpoints {
  static const double mobile = 768;
  static const double tablet = 1100;
  static const double desktop = 1100;

  static bool isMobile(double width) => width < mobile;

  static bool isTablet(double width) => width >= mobile && width < desktop;

  static bool isDesktop(double width) => width >= desktop;
}
