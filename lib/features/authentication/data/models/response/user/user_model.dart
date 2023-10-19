// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name:'_id') required String id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String email,
    String? address,
    String? token,
    String? phone,
    String? image,
    @JsonKey(name: 'job_title') String? jobTitle,
    @JsonKey(name: 'job_description') String? jobDescription,
    String? company,
    List<String>? skills,
    String? createdAt,
    @JsonKey(name:'is_agent') required bool isAgent,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  factory User.empty() => const User(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    isAgent: false,
  );
}
