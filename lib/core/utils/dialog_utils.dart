import 'package:flutter/material.dart';

/// Utility class for showing dialogs that adapt to screen size
class DialogUtils {
  /// Shows a dialog that becomes full-screen on mobile devices
  static Future<T?> showAdaptiveDialog<T>({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (isMobile) {
      // Full-screen modal for mobile
      return Navigator.of(context).push<T>(
        MaterialPageRoute(
          builder: builder,
          fullscreenDialog: true,
        ),
      );
    } else {
      // Regular dialog for desktop/tablet
      return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: builder,
      );
    }
  }
}

