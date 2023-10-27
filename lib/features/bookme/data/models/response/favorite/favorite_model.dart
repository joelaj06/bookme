// ignore_for_file: invalid_annotation_target

import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../authentication/data/models/response/user/user_model.dart';

part 'favorite_model.freezed.dart';
part 'favorite_model.g.dart';

@freezed
class Favorite with _$Favorite {
  const factory Favorite({
   @JsonKey(name: '_id') required String id,
    required Service service,
    required User user,
  }) = _Favorite;

  const Favorite._();

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  factory Favorite.empty() =>  Favorite(
    id: '',
    service: Service.empty(),
    user: User.empty(),
  );
}
