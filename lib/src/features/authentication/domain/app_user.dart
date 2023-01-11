import 'dart:convert';

/// Simple class representing the user UID and email.
class AppUser {
  AppUser([this.user = const {}]);

  final Map<String, String> user;

  Map<String, dynamic> toMap() {
    return {
      'user': user,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      Map<String, String>.from(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}
