import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

/// App - Root widget for the Trusted application
///
/// Configures:
/// - Theme (dark mode with Design System)
/// - Router (GoRouter for navigation)
/// - System UI overlays
///
/// No external state management needed - individual features manage their own state
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Configure system UI
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF061012),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    final router = AppRouter.createRouter();

    return MaterialApp.router(
      title: 'Trusted - Gaming Marketplace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}

