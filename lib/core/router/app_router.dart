import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/login/presentation/screens/login_screen.dart';
import '../../features/signup/presentation/screens/signup_screen.dart';
import '../../features/forgot_password/presentation/screens/forgot_password_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/games/presentation/screens/games_screen.dart';
import '../../features/security_privacy/presentation/screens/security_privacy_screen_wrapper.dart';
import '../../features/buy/presentation/screens/buy_screen.dart';
import '../../features/buy/presentation/screens/choose_mediator_screen.dart';
import '../../features/buy/presentation/screens/mediator_profile_screen.dart';
import '../../features/buy/presentation/screens/payment_screen.dart';
import '../../features/buy/data/models/buy_mediator_model.dart';
import '../../features/chat/presentation/screens/chat_list_screen.dart';
import '../../features/chat/presentation/screens/chat_detail_screen.dart';
import '../../features/chat/data/models/chat_model.dart';
import '../../features/profile/presentation/screens/all_listings_screen.dart';
import '../../features/profile/presentation/screens/add_listing_screen.dart';
import '../../core/widgets/main_nav_shell.dart';

/// App Router Configuration
///
/// Clean navigation using GoRouter
/// Flow:
/// 1. Splash → checks auth/onboarding state
/// 2. Navigate accordingly → Onboarding/Login/Home
///
/// Navigation logic is handled by individual screens via BlocListener
/// Router only provides route definitions
class AppRouter {
  const AppRouter._();

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        // Splash Screen (Entry point)
        GoRoute(
          path: '/',
          name: 'splash',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SplashScreen(),
          ),
        ),

        // Onboarding Flow
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const OnboardingScreen(),
          ),
        ),

        // Authentication Flow - Login
        GoRoute(
          path: '/auth/login',
          name: 'login',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const LoginScreen(),
          ),
        ),

        // Authentication Flow - Signup
        GoRoute(
          path: '/auth/signup',
          name: 'signup',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SignupScreen(),
          ),
        ),

        // Authentication Flow - Forgot Password
        GoRoute(
          path: '/auth/forgot-password',
          name: 'forgot-password',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ForgotPasswordScreen(),
          ),
        ),

        // Main App Navigation Shell (Authenticated)
        GoRoute(
          path: '/main',
          name: 'main',
          pageBuilder: (context, state) {
            // Get initial tab index from query parameter or default to 4 (profile)
            final initialTab = int.tryParse(
                  state.uri.queryParameters['tab'] ?? '4',
                ) ??
                4;

            return MaterialPage(
              key: state.pageKey,
              child: MainNavShell(initialIndex: initialTab),
            );
          },
        ),

        // Notifications Screen (standalone)
        GoRoute(
          path: '/notifications',
          name: 'notifications',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const NotificationsScreen(),
          ),
        ),

        // Games Screen (standalone)
        GoRoute(
          path: '/games',
          name: 'games',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const GamesScreen(),
          ),
        ),

        // Security & Privacy Screen (standalone)
        GoRoute(
          path: '/security-privacy',
          name: 'security-privacy',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SecurityPrivacyScreenWrapper(),
          ),
        ),

        // Buy Screen (standalone with product)
        GoRoute(
          path: '/buy/:productId',
          name: 'buy',
          pageBuilder: (context, state) {
            final productId = state.pathParameters['productId'] ?? '1';
            return MaterialPage(
              key: state.pageKey,
              child: BuyScreen(productId: productId),
            );
          },
        ),

        // Choose Mediator Screen
        GoRoute(
          path: '/choose-mediator',
          name: 'choose-mediator',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: ChooseMediatorScreen(
                mediators: BuyMediatorModel.mockMediators,
              ),
            );
          },
        ),

        // Mediator Profile Screen
        GoRoute(
          path: '/mediator-profile/:mediatorId',
          name: 'mediator-profile',
          pageBuilder: (context, state) {
            final mediatorId = state.pathParameters['mediatorId'] ?? '';
            final mediator = BuyMediatorModel.mockMediators.firstWhere(
              (m) => m.id == mediatorId,
              orElse: () => BuyMediatorModel.mockMediators.first,
            );
            return MaterialPage(
              key: state.pageKey,
              child: MediatorProfileScreen(mediator: mediator),
            );
          },
        ),

        // Payment Screen
        GoRoute(
          path: '/payment/:mediatorId',
          name: 'payment',
          pageBuilder: (context, state) {
            final mediatorId = state.pathParameters['mediatorId'] ?? '';
            final amount = double.tryParse(
                  state.uri.queryParameters['amount'] ?? '100',
                ) ??
                100.0;
            final mediator = BuyMediatorModel.mockMediators.firstWhere(
              (m) => m.id == mediatorId,
              orElse: () => BuyMediatorModel.mockMediators.first,
            );
            return MaterialPage(
              key: state.pageKey,
              child: PaymentScreen(
                mediator: mediator,
                amount: amount,
              ),
            );
          },
        ),

        // Chat List Screen
        GoRoute(
          path: '/chat',
          name: 'chat',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const ChatListScreen(),
            );
          },
        ),

        // Chat Detail Screen
        GoRoute(
          path: '/chat/:chatId/:chatType',
          name: 'chat-detail',
          pageBuilder: (context, state) {
            final chatId = state.pathParameters['chatId'] ?? '';
            final chatTypeString = state.pathParameters['chatType'] ?? 'private';
            final chatType = ChatType.values.firstWhere(
              (e) => e.name == chatTypeString,
              orElse: () => ChatType.private,
            );
            return MaterialPage(
              key: state.pageKey,
              child: ChatDetailScreen(
                chatId: chatId,
                chatType: chatType,
              ),
            );
          },
        ),

        // All Listings Screen
        GoRoute(
          path: '/listings/all',
          name: 'all-listings',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const AllListingsScreen(),
            );
          },
        ),

        // Add Listing Screen
        GoRoute(
          path: '/listings/add',
          name: 'add-listing',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const AddListingScreen(),
            );
          },
        ),
      ],
      errorBuilder: (context, state) => _ErrorScreen(
        uri: state.uri.toString(),
      ),
    );
  }
}

/// Error Screen (404)
class _ErrorScreen extends StatelessWidget {
  final String uri;

  const _ErrorScreen({required this.uri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              uri,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to Splash'),
            ),
          ],
        ),
      ),
    );
  }
}
