import 'dart:convert';

class User {
  final String firstName;
  final String userPicture;
  final String email;
  User({
    required this.firstName,
    required this.userPicture,
    required this.email,
  });

  User copyWith({
    String? firstName,
    String? userPicture,
    String? email,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      userPicture: userPicture ?? this.userPicture,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'userPicture': userPicture,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] as String,
      userPicture: map['userPicture'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'User(firstName: $firstName, userPicture: $userPicture, email: $email)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.userPicture == userPicture &&
        other.email == email;
  }

  @override
  int get hashCode =>
      firstName.hashCode ^ userPicture.hashCode ^ email.hashCode;
}
