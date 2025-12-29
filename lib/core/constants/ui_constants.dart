/// UI Constants for consistent design across the app
class UIConstants {
  // Private constructor to prevent instantiation
  UIConstants._();

  // ============================================================================
  // BREAKPOINTS
  // ============================================================================

  /// Extra small screen breakpoint (< 400px) - very narrow mobile devices
  static const double breakpointXSmall = 400;

  /// Small screen breakpoint (< 600px) - small mobile devices
  static const double breakpointSmall = 600;

  /// Medium screen breakpoint (< 700px) - used for some responsive layouts
  static const double breakpointMedium = 700;

  /// Mobile breakpoint (< 768px) - mobile vs tablet/desktop
  static const double breakpointMobile = 768;

  /// Desktop breakpoint (< 1024px) - tablet vs desktop
  static const double breakpointDesktop = 1024;

  // ============================================================================
  // SPACING
  // ============================================================================

  /// Extra small spacing (4px)
  static const double spacingXs = 4;

  /// Small spacing (8px)
  static const double spacingS = 8;

  /// Medium spacing (12px)
  static const double spacingM = 12;

  /// Large spacing (16px)
  static const double spacingL = 16;

  /// Extra large spacing (20px)
  static const double spacingXl = 20;

  /// Extra extra large spacing (24px)
  static const double spacingXxl = 24;

  /// Huge spacing (32px)
  static const double spacingHuge = 32;

  // ============================================================================
  // DIALOG SIZES
  // ============================================================================

  /// Mobile dialog width (double.infinity)
  static const double dialogWidthMobile = double.infinity;

  /// Desktop dialog max width (600px)
  static const double dialogWidthDesktop = 600;

  /// Large dialog max width (900px)
  static const double dialogWidthLarge = 900;

  /// Dialog max height multiplier (0.85)
  static const double dialogMaxHeightMultiplier = 0.85;

  /// Dialog max height multiplier for full content (0.9)
  static const double dialogMaxHeightFullMultiplier = 0.9;

  // ============================================================================
  // ANIMATION DURATIONS
  // ============================================================================

  /// Fast animation duration (200ms)
  static const int durationFast = 200;

  /// Normal animation duration (300ms)
  static const int durationNormal = 300;

  /// Slow animation duration (500ms)
  static const int durationSlow = 500;

  // ============================================================================
  // OTHER
  // ============================================================================

  /// Badge card height (160px)
  static const double badgeCardHeight = 160;

  /// Equipment card height (380px)
  static const double equipmentCardHeight = 380;
}

/// Helper extension for MediaQuery to check breakpoints
extension BreakpointExtension on double {
  /// Check if screen is extra small (< 400px)
  bool get isXSmallScreen => this < UIConstants.breakpointXSmall;

  /// Check if screen is small (< 600px)
  bool get isSmallScreen => this < UIConstants.breakpointSmall;

  /// Check if screen is mobile (< 768px)
  bool get isMobile => this < UIConstants.breakpointMobile;

  /// Check if screen is tablet (>= 768px && < 1024px)
  bool get isTablet => this >= UIConstants.breakpointMobile && this < UIConstants.breakpointDesktop;

  /// Check if screen is desktop (>= 1024px)
  bool get isDesktop => this >= UIConstants.breakpointDesktop;

  /// Check if screen is medium (< 700px)
  bool get isMediumScreen => this < UIConstants.breakpointMedium;
}
