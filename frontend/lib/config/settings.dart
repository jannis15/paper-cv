import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    @Default('en') String locale,
    @Default(true) bool showAdBanner,
  }) = _Settings;
}
