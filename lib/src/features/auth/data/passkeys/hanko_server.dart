import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:passkeys/passkey_auth.dart';
import 'package:passkeys/relying_party_server/relying_party_server.dart';
import 'package:passkeys/relying_party_server/types/authentication.dart';
import 'package:passkeys/relying_party_server/types/registration.dart';
import 'package:travee/api/api.dart';
import 'package:travee/src/features/auth/data/auth_repository.dart';
import 'package:travee/src/features/auth/domain/passkeys/register/init_register.dart';

class HankoServer implements RelyingPartyServer<Request, Response> {
  // an instance of a HTTP client that can perform the required 4 types of requests against your relying party server
  // - initRegister
  // - completeRegister
  // - initAuthenticate
  // - completeAuthenticate
  final AuthRepository _client;

  HankoServer(this._client);

  @override
  Future<Response> completeAuthenticate(AuthenticationCompleteRequest request) {
    // // build the request that your backend (and thus your client) expects
    // const request = YouApiClientAuthenticateRequest.from(request);

    // // make the completeAuthenticate call to your relying party server
    // const response = _client.completeAuthenticate(request);

    // // map the backend response to the Response class
    // return Response(idToken: response.idToken);
    throw UnimplementedError();
  }

  @override
  Future<Response> completeRegister(RegistrationCompleteRequest request) async {
    final response = await _client.finalizeWebAuthn(
        attestationObject: request.attestationObject,
        clientDataJson: request.clientDataJSON,
        id: request.id,
        rawId: request.rawId);
    return response as Response;
  }

  @override
  Future<AuthenticationInitResponse> initAuthenticate(Request request) {
    // similar in its structure to completeAuthenticate
    throw UnimplementedError();
  }

  @override
  Future<RegistrationInitResponse> initRegister(Request request) async {
    final response = await _client.initializeWebAuthn();
    PublicKey publicKey = PublicKey.fromJson(response['publicKey']);
    final initResponse = RegistrationInitResponse(
        RelyingParty(publicKey.rp.name, publicKey.rp.id),
        User(
            publicKey.user.displayName, publicKey.user.id, publicKey.user.name),
        publicKey.challenge,
        AuthenticatorSelection(
            "platform",
            publicKey.authenticatorSelection.requireResidentKey,
            publicKey.authenticatorSelection.residentKey,
            publicKey.authenticatorSelection.userVerification));
    return initResponse;
  }
}

// Define all fields in this class that your relying party server expects during the initial sign up and login call
// At most, this must contain some kind of user identifier (e.g. an email address).
class Request {
  const Request({required this.email});

  final String email;
}

// Define all data in this class that can be returned by your relying party server on a successful authentication.
// Usually this is some kind of token (e.g. a JWT token that encodes user data).
class Response {
  const Response({required this.idToken});

  final String idToken;
}

final hankoNotifierProvider = Provider<PasskeyAuth>((ref) => PasskeyAuth(
      HankoServer(AuthRepository(api: TraveeAPI(Dio(), ref), ref: ref)),
    ));
