import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travee/api/api.dart';
import 'package:travee/api/api_exception.dart';
import 'package:travee/src/features/auth/application/auth_storage.dart';

class AuthRepository {
  final Ref ref;
  final TraveeAPI api;
  AuthRepository({required this.api, required this.ref});

  Future<Map<String, dynamic>> checkEmail({required String email}) async {
    ref.read(authStorageProvider).saveEmail(email: email);
    try {
      final body = {'email': email};
      final response = await api.authpost(path: '/user', body: body);

      ///* IF THIS RETURNS [200], THEN WE GET THE [email_id & id] SENT AS A RESPONSE
      ///? RESPONSE DATA {id: e11de0dd-dd89-4109-a8f5-08e901f847fb, email_id: 644ca23e-0af0-4233-b76e-6495a4c57e10, verified: true, has_webauthn_credential: false}
      ///* WE THEN MOVE TO THE [initializePasscodeLogin] FUNCTION
      ///* IF IT RETURNS [404], THEN THERE IS NO USER.
      ///? RESPONSE (NO DATA) {code: 404, message: Not Found}
      ///* WE THEN MOVE TO THE [register] FUNCTION
      return api.handleResponse(response);
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  Future<Map<String, dynamic>> register({required String email}) async {
    try {
      final body = {"email": email};
      final response = await api.authpost(path: '/users', body: body);
      return api.handleResponse(response, error400: "User already registered.");
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  ///* This function sends a 6 digit passcode to the email of the user
  ///* It receives [email_id & user_id] as parameters
  Future<Map<String, dynamic>> initializePasscodeLogin() async {
    final emailId = await ref.read(authStorageProvider).getEmailId();
    final id = await ref.read(authStorageProvider).getId();
    try {
      final body = {"email_id": emailId, "user_id": id};
      final response =
          await api.authpost(path: '/passcode/login/initialize', body: body);

      ///* At this point, if it is successful, an email is sent to the user
      ///* that contains a string of 6 decimal digits.
      ///* So update the UI for the user to know.
      return api.handleResponse(response);
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  ///* This function confirms the 6 digit passcode sent to the user.
  ///* and finalizes the login of the user.
  Future<Map<String, dynamic>> finalizePasscodeLogin(
      {required String code}) async {
    final id = await ref.read(authStorageProvider).getId();
    try {
      final body = {"code": code, "id": id};
      final response =
          await api.authpost(path: '/passcode/login/finalize', body: body);

      ///* If successful, A JWT token comes with the Headers.
      ///* It is a [x-auth-token] token.
      ///
      ///* At this point, the user can [optionally] create a passkey.
      ///* Creating a passkey goes to [initializeWebAuthn] function
      return api.handleResponse(response);
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  Future<Map<String, dynamic>> initializeWebAuthn() async {
    final token = await ref.read(authStorageProvider).getToken();
    try {
      final response = await api.authpost(
          path: '/webauthn/registration/initialize',
          body: {},
          useBearerToken: true,
          token: token);
      return api.handleResponse(response);
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  Future<Response> finalizeWebAuthn({
    required String id,
    required String rawId,
    required String attestationObject,
    required String clientDataJson,
  }) async {
    final body = {
      'id': id,
      'rawId': rawId,
      'response': {
        'attestationObject': attestationObject,
        'clientDataJson': clientDataJson,
        'transports': ['internal'],
        'type': 'public-key'
      },
    };
    final token = await ref.read(authStorageProvider).getToken();
    try {
      final response = await api.authpost(
          path: '/webauthn/registration/finalize',
          body: body,
          useBearerToken: true,
          token: token);
      return response;
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}

///* This provider is exposed to the main app.
final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepository(api: TraveeAPI(Dio(), ref), ref: ref));
