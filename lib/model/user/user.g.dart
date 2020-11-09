// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['token'] == null
        ? null
        : Token.fromJson(json['token'] as Map<String, dynamic>),
    json['user'] == null
        ? null
        : ItemUser.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

ItemUser _$ItemUserFromJson(Map<String, dynamic> json) {
  return ItemUser(
    json['id'] as int,
    json['fullname'] as String,
    json['username'] as String,
    json['email'] as String,
    json['level'] as String,
  );
}

Map<String, dynamic> _$ItemUserToJson(ItemUser instance) => <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'username': instance.username,
      'email': instance.email,
      'level': instance.level,
    };
