// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request.freezed.dart';
part 'user_request.g.dart';

@freezed
class UserRequest with _$UserRequest {
  const factory UserRequest({
    String? id,
    @JsonKey(name: 'first_name')  String? firstName,
    @JsonKey(name: 'last_name')  String? lastName,
     String? email,
    String? address,
    String? phone,
    String? password,
    String? confirmPassword,
    String? image,
    @JsonKey(name: 'job_title') String? jobTitle,
    @JsonKey(name: 'job_description') String? jobDescription,
    String? company,
    List<String>? skills,
    @JsonKey(name:'is_agent') bool? isAgent,
  }) = _UserRequest;

  const UserRequest._();

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);


}
