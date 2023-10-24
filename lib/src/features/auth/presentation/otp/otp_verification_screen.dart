// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travee/src/features/auth/data/auth_repository.dart';
import 'package:travee/src/features/auth/presentation/passkeys/create_passkey.dart';

class OTPScreen extends StatefulHookConsumerWidget {
  const OTPScreen({super.key});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                hintText: 'Enter OTP',
                counterText: '',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                String otp = otpController.text;
                // Example: Check if OTP is valid
                if (otp.length == 6) {
                  // OTP is valid, proceed with verification
                  debugPrint('OTP loading: $otp');
                  final response = await auth.finalizePasscodeLogin(code: otp);
                  if (response['success'] != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CreatePasskey()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              'Wrong token. Check the token and try again.')),
                    );
                  }
                } else {
                  // Show an error if the OTP is not 6 digits
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a 6-digit OTP')),
                  );
                }
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyOTP(BuildContext context) {
    // Add your OTP verification logic here
    String otp = otpController.text;
    // Example: Check if OTP is valid
    if (otp.length == 6) {
      // OTP is valid, proceed with verification
      debugPrint('OTP Verified: $otp');
    } else {
      // Show an error if the OTP is not 6 digits
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a 6-digit OTP')),
      );
    }
  }
}
