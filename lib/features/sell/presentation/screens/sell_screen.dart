import 'package:flutter/material.dart';
import 'sell_listing_screen.dart';

/// SellScreen - Entry point for selling accounts
///
/// Redirects to the new SellListingScreen
class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SellListingScreen();
  }
}
