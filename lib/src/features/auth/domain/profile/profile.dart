import 'dart:convert';

class Profile {
  final String name;
  final String picture;
  Profile({
    required this.name,
    required this.picture,
  });

  Profile copyWith({
    String? name,
    String? picture,
  }) {
    return Profile(
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'picture': picture,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'] as String,
      picture: map['picture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Profile(name: $name, picture: $picture)';

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.name == name && other.picture == picture;
  }

  @override
  int get hashCode => name.hashCode ^ picture.hashCode;
}
