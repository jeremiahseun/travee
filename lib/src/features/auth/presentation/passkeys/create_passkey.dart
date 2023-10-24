// ignore_for_file: use_build_context_synchronously

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:travee/src/features/auth/data/passkeys/hanko_server.dart';
import 'package:travee/src/features/menu/presentation/home/home_screen.dart';
import 'package:travee/src/flutter_flow_theme.dart';

class CreatePasskey extends HookConsumerWidget {
  const CreatePasskey({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(hankoNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectionArea(
                  child: Text(
                'You can create a passkey',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      lineHeight: 1.2,
                    ),
                textAlign: TextAlign.center,
              )),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: SelectionArea(
                    child: Text(
                  'This will enable faster login next time.',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Poppins',
                        lineHeight: 1.5,
                      ),
                )),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: ElevatedButton(
                    onPressed: () async {
                      final response = await auth.registerWithEmail(
                          const Request(email: 'erinolaerry@gmail.com'));
                      if (response != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text('There is something wrong. Try again')),
                        );
                      }
                    },
                    child: const Text("Create passkey")),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    },
                    child: const Text("Skip")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
