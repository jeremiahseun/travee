import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/features/auth/presentation/onboarding/onboarding_screen.dart';

const supabaseUrl = 'https://qseaavlfwogqywhhiopu.supabase.co';
const supabaseKey = String.fromEnvironment('SUPABASE_KEY');
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey, debug: true);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true, textTheme: GoogleFonts.dmSansTextTheme()),
      home: OnboardingScreen(),
    );
  }
}
