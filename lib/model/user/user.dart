import 'package:json_annotation/json_annotation.dart';

import 'package:login/model/token/token.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  Token token;
  ItemUser user;
  @JsonKey(ignore: true)
  String error;

  User(this.token, this.user);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User.withError(this.error);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{token:$token, user:$user}';
  }
}

@JsonSerializable()
class ItemUser {
  int id;
  String fullname;
  String username;
  String email;
  String level;

  ItemUser(
    this.id,
    this.fullname,
    this.username,
    this.email,
    this.level,
  );

  factory ItemUser.fromJson(Map<String, dynamic> json) =>
      _$ItemUserFromJson(json);

  Map<String, dynamic> toJson() => _$ItemUserToJson(this);

  @override
  String toString() {
    return 'ItemUser{id: $id,fullname: $fullname, username: $username, email: $email, level: $level}';
  }
}
