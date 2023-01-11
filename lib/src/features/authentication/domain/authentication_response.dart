import 'dart:convert';

class BaseResponse {
  int? status;
  String? message;
}

class UserResponse {
  String? name;
  String? phone;

  UserResponse(this.name, this.phone);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      map['name'],
      map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source));
}

class AuthenticationResponse extends BaseResponse {
  UserResponse? user;

  AuthenticationResponse(this.user);

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
    };
  }

  factory AuthenticationResponse.fromMap(Map<String, dynamic> map) {
    return AuthenticationResponse(
      map['user'] != null ? UserResponse.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationResponse.fromJson(String source) =>
      AuthenticationResponse.fromMap(json.decode(source));
}
