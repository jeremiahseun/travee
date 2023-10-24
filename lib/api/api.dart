import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travee/src/features/auth/application/auth_storage.dart';

class TraveeAPI {
  final Dio client;
  final Ref ref;
  final url =
      Uri.parse('https://ba7d6f8b-e82e-4204-8df3-5a242448b1fc.hanko.io');

  TraveeAPI(this.client, this.ref);

  Future<Response> get({required String path}) async {
    log("Sending a GET request to $path");
    final response = await client.get("$url$path");
    log("Response from a GET request ${response.statusCode}");
    return response;
  }

  Future<Response> authget({
    required String path,
    required String token,
  }) async {
    log("Sending an Auth GET request to $path");
    final response = await client.get("$url$path",
        options: Options(headers: {'Content-Type': 'application/json'}));
    log("Response from a Auth GET request ${response.statusCode}");
    return response;
  }

  Future<Response> post(
      {required String path, required Map<String, dynamic> body}) async {
    log("Sending a POST request to $path\n$body");
    final response = await client.post("$url$path", data: body);
    log("Response from a POST request ${response.statusCode}");
    return response;
  }

  Future<Response> authpost(
      {required String path,
      required Map<String, dynamic> body,
      String? token,
      bool useBearerToken = false}) async {
    log("Sending an Auth POST request to $path\n$body");
    try {
      final response = await client.post("$url$path",
          data: body,
          options: Options(
              headers: useBearerToken
                  ? {'Authorization': 'Bearer ${token?.trim()}'}
                  : {'Content-Type': 'application/json'},
              followRedirects: false));
      log('RESPONSE: $response');
      log("Response from a Auth POST request ${response.statusCode}");
      return response;
    } on SocketException catch (e) {
      log("Network Error (Timeout):> ${e.message}");
      log("Network Error (Timeout):> ${e.address?.address}");
      return Response(requestOptions: RequestOptions());
    } on DioException catch (e) {
      if (e.response != null) {
        log("Error from Dio (Response): ${e.response}");
        log("Error from Dio: ${e.response?.data}");
        log("Error from Dio: ${e.response?.headers}");
        log("Error from Dio: ${e.response?.requestOptions}");
      }
      log("Error from Dio:> ${e.error}");
      log("Error from Dio:>> ${e.message}");
      log("Error from Dio:>>> ${e.type.name}");
      log("Error from Dio:>>>> ${e.requestOptions.baseUrl}");
      return e.response ?? Response(requestOptions: RequestOptions());
    }
  }

  Map<String, dynamic> handleResponse(Response response, {String? error400}) {
    if (response.headers['x-auth-token'] != null) {
      final headers = response.headers['x-auth-token'];
      ref.read(authStorageProvider).saveToken(token: "${headers?.first}");
      log("LOGGED IN SUCCESSFULLY: WE GET A HEADER TOKEN THAT IS: ${headers?.first}");
    }

    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> data;
        if (response.data is String) {
          data = jsonDecode(response.data);
        } else {
          data = response.data;
        }
        if (data['id'] != null) {
          ref.read(authStorageProvider).saveId(id: data['id']);
          log("ID saved: ${data['id']}");
        }
        if (data['email_id'] != null) {
          ref.read(authStorageProvider).saveEmailId(emailId: data['email_id']);
          log("Email ID saved: ${data['email_id']}");
        }
        if (data['user_id'] != null) {
          ref.read(authStorageProvider).saveUserId(userId: data['user_id']);
          log("User ID saved: ${data['user_id']}");
        }
        log(data.toString());
        log(response.headers.toString());
        final successRes = <String, dynamic>{"success": true};
        data.addEntries(successRes.entries);
        return data;
      case 201:
        final Map<String, dynamic> data;
        if (response.data is String) {
          data = jsonDecode(response.data);
        } else {
          data = response.data;
        }
        if (data['id'] != null) {
          ref.read(authStorageProvider).saveId(id: data['id']);
          log("ID saved: ${data['id']}");
        }
        if (data['email_id'] != null) {
          ref.read(authStorageProvider).saveEmailId(emailId: data['email_id']);
          log("Email ID saved: ${data['email_id']}");
        }
        if (data['user_id'] != null) {
          ref.read(authStorageProvider).saveUserId(userId: data['user_id']);
          log("User ID saved: ${data['user_id']}");
        }
        log(data.toString());
        log(response.headers.toString());
        final successRes = <String, dynamic>{"success": true};
        data.addEntries(successRes.entries);
        return data;
      case 400:
        return {"success": false, "message": error400 ?? "Invalid Credentials"};
      case 404:
        return {"success": false, "message": "User not found"};
      case 409:
        return {"success": false, "message": "User already exist"};
      default:
        return {
          "success": false,
          "message": "Sorry, something went wrong. Kindly try again"
        };
    }
  }
}
