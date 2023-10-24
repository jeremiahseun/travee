class PublicKey {
  AttestationBackend attestation;
  AuthenticatorSelectionBackend authenticatorSelection;
  String challenge;
  List<PubKeyCredParamsBackend> pubKeyCredParams;
  RelyingPartyBackend rp;
  dynamic timeout;
  UserBackend user;

  PublicKey({
    required this.attestation,
    required this.authenticatorSelection,
    required this.challenge,
    required this.pubKeyCredParams,
    required this.rp,
    required this.timeout,
    required this.user,
  });

  factory PublicKey.fromJson(Map<String, dynamic> json) {
    return PublicKey(
      attestation: AttestationBackend(attestation: json['attestation']),
      authenticatorSelection: AuthenticatorSelectionBackend.fromJson(
          json['authenticatorSelection']),
      challenge: json['challenge'],
      pubKeyCredParams: (json['pubKeyCredParams'] as List)
          .map((item) => PubKeyCredParamsBackend.fromJson(item))
          .toList(),
      rp: RelyingPartyBackend.fromJson(json['rp']),
      timeout: json['timeout'],
      user: UserBackend.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attestation': attestation.toJson(),
      'authenticatorSelection': authenticatorSelection.toJson(),
      'challenge': challenge,
      'pubKeyCredParams':
          pubKeyCredParams.map((param) => param.toJson()).toList(),
      'rp': rp.toJson(),
      'timeout': timeout,
      'user': user.toJson(),
    };
  }
}

class AttestationBackend {
  String attestation;

  AttestationBackend({
    required this.attestation,
  });

  factory AttestationBackend.fromJson(Map<String, dynamic> json) {
    return AttestationBackend(
      attestation: json['attestation'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'attestation': attestation,
    };
  }
}

class AuthenticatorSelectionBackend {
  // String authenticatorAttachment;
  bool requireResidentKey;
  String residentKey;
  String userVerification;

  AuthenticatorSelectionBackend({
    // required this.authenticatorAttachment,
    required this.requireResidentKey,
    required this.residentKey,
    required this.userVerification,
  });

  factory AuthenticatorSelectionBackend.fromJson(Map<String, dynamic> json) {
    return AuthenticatorSelectionBackend(
      // authenticatorAttachment: json['authenticatorAttachment'],
      requireResidentKey: json['requireResidentKey'],
      residentKey: json['residentKey'],
      userVerification: json['userVerification'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      // 'authenticatorAttachment': authenticatorAttachment,
      'requireResidentKey': requireResidentKey,
      'residentKey': residentKey,
      'userVerification': userVerification,
    };
  }
}

class PubKeyCredParamsBackend {
  int alg;
  String type;

  PubKeyCredParamsBackend({
    required this.alg,
    required this.type,
  });

  factory PubKeyCredParamsBackend.fromJson(Map<String, dynamic> json) {
    return PubKeyCredParamsBackend(
      alg: json['alg'],
      type: json['type'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'alg': alg,
      'type': type,
    };
  }
}

class RelyingPartyBackend {
  String id;
  String name;

  RelyingPartyBackend({
    required this.id,
    required this.name,
  });

  factory RelyingPartyBackend.fromJson(Map<String, dynamic> json) {
    return RelyingPartyBackend(
      id: json['id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class UserBackend {
  String displayName;
  String id;
  String name;

  UserBackend({
    required this.displayName,
    required this.id,
    required this.name,
  });

  factory UserBackend.fromJson(Map<String, dynamic> json) {
    return UserBackend(
      displayName: json['displayName'],
      id: json['id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'id': id,
      'name': name,
    };
  }
}
