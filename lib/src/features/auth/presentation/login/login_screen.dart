// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travee/src/features/auth/data/auth_repository.dart';
import 'package:travee/src/features/auth/data/passkeys/hanko_server.dart';
import 'package:travee/src/features/auth/presentation/otp/otp_verification_screen.dart';
import 'package:travee/src/flutter_flow_theme.dart';
import 'package:travee/src/utils/travee_snackbar.dart';

class LoginWidget extends StatefulHookConsumerWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final controller = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authHanko = ref.read(hankoNotifierProvider);
    final authRepository = ref.read(authRepositoryProvider);
    return GestureDetector(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Align(
            alignment: const AlignmentDirectional(0.00, 0.00),
            child: Container(
              width: 360,
              decoration: const BoxDecoration(),
              child: Align(
                alignment: const AlignmentDirectional(0.00, 0.00),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Color(0x1917171C),
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SelectionArea(
                          child: Text(
                        'Welcome to Travee',
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 1.2,
                                ),
                      )),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: SelectionArea(
                            child: Text(
                          'Continue with your email',
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    lineHeight: 1.5,
                                  ),
                        )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: controller,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16,
                                            lineHeight: 1.5,
                                          ),
                                      hintText: 'Enter your email',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16,
                                            lineHeight: 1.5,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFD0D5DD),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFDA29B),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFDA29B),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              14, 10, 14, 10),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16,
                                          lineHeight: 1.5,
                                        ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Email can't be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final response = await authRepository
                                    .checkEmail(email: controller.text.trim());
                                if (response['success'] != null) {
                                  NotifyMessage.successMessage(
                                      message:
                                          'Successfully logged in. Sending OTP to your email.',
                                      context: context);
                                  final res = await authRepository
                                      .initializePasscodeLogin();
                                  if (res['success'] != null) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OTPScreen()));
                                  } else {
                                    NotifyMessage.errorMessage(
                                        message: res['message'],
                                        context: context);
                                  }
                                } else {
                                  ///* THERE IS NO USER. REGISTERING THE USER
                                  NotifyMessage.infoMessage(
                                      message:
                                          'There is no account with this email. Creating it now...',
                                      context: context);
                                  final response = await authRepository
                                      .register(email: "erinolaerry@gmail.com");
                                  if (response['success'] != null) {
                                    NotifyMessage.successMessage(
                                        message:
                                            'Successfully signed up. Sending OTP to your email.',
                                        context: context);
                                    final res = await authRepository
                                        .initializePasscodeLogin();
                                    if (res['success'] != null) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OTPScreen()));
                                    } else {
                                      NotifyMessage.errorMessage(
                                          message: response['message'],
                                          context: context);
                                    }
                                  } else {
                                    NotifyMessage.warningMessage(
                                        message:
                                            "Put in your email. Let us get started!",
                                        context: context);
                                  }
                                }
                              }
                            },
                            child: const Text("Continue with email")),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: FilledButton(
                            onPressed: () {
                              authHanko.authenticateWithEmail(const Request(
                                  email: 'seunjeremiah@gmail.com'));
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const HomeScreen()));
                            },
                            child: const Text("Use a passkey")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
