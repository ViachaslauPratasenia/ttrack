import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/sessions/presentation/pages/log_entry_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      themeMode: ThemeMode.light,
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadSlateColorScheme.light(),
      ),
      appBuilder: (context) {
        return MaterialApp(
          title: 'Spin Track',
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          builder: (context, child) {
            return ShadAppBuilder(child: child!);
          },
          // TODO: Add proper auth check, for now showing Dashboard for testing
          // home: const LoginPage(),
          home: const DashboardPage(),
          routes: {
            '/login': (context) => const LoginPage(),
            '/dashboard': (context) => const DashboardPage(),
            '/log-entry': (context) => const LogEntryPage(),
          },
        );
      },
    );
  }
}
