import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:travee/src/features/auth/presentation/login/login_screen.dart';

import 'onboarding_screen_controller.dart';

class OnboardingScreen extends ConsumerWidget {
  OnboardingScreen({super.key});

  final onboard = [
    {
      'title': "Explorer\nthe world",
      'picture': 'assets/images/one-light.png',
      'colorone': '0xFFFFBC7F',
      'colortwo': '0xFFFFF5EF'
    },
    {
      'title': "Safe and\neasy",
      'picture': 'assets/images/two-light.png',
      'colorone': '0xFFB7FF8B',
      'colortwo': '0xFFF3FFEF'
    },
    {
      'title': "Welcome\nto Travee",
      'picture': 'assets/images/three-light.png',
      'colorone': '0xFF88C5FF',
      'colortwo': '0xFFFFFFFF'
    },
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingController = ref.read(onboardingProvider);
    return Scaffold(
      body: PageView.builder(
          controller: onboardingController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            return OnboardWidget(
              title: onboard[i]['title']!,
              picture: onboard[i]['picture']!,
              colors: [
                Color(int.parse(onboard[i]['colorone']!)),
                Color(int.parse(onboard[i]['colortwo']!))
              ],
            );
          }),
    );
  }
}

class OnboardWidget extends HookConsumerWidget {
  final String title;
  final String picture;
  final List<Color> colors;
  const OnboardWidget({
    Key? key,
    required this.title,
    required this.picture,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      clipBehavior: Clip.antiAlias,
      height: double.infinity,
      width: double.infinity,
      decoration: ShapeDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.82, 0.62),
          radius: 0.07,
          colors: colors,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            picture,
            width: double.infinity,
            fit: BoxFit.cover,
          ).animate(delay: 1000.ms).fade().moveX(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(70),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                ).animate(delay: 1300.ms).fade().shimmer(),
                const Gap(24),
                Text(
                  "Let's start here",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const Gap(50),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginWidget())),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 72,
                      height: 72,
                      padding: const EdgeInsets.all(24),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF5900),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Icon(Icons.arrow_forward_outlined)),
                ),
              ],
            ),
          )
        ],
      ),
    ).animate().fade(duration: 700.ms);
  }
}
