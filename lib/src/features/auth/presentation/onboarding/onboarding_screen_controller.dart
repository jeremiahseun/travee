import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingController extends ChangeNotifier {
  final pageController = PageController();
  void changePage() {
    if (pageController.page == 2.0) {
      
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    }
    notifyListeners();
  }
}

final onboardingProvider =
    Provider<OnboardingController>((ref) => OnboardingController());
