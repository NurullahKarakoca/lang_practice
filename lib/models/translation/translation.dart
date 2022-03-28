import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation.freezed.dart';

part 'translation.g.dart';

@freezed
class Translation with _$Translation {
  const factory Translation(
    String title,
    @TranslationTypeJsonConverter() TranslationType type, {
    @JsonKey(ignore: true) String? wordId,
  }) = _Translation;

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);
}

@freezed
class TranslationType with _$TranslationType {
  const factory TranslationType.none() = _None;

  const factory TranslationType.verb() = _Verb;

  const factory TranslationType.adverb() = _Adverb;

  const factory TranslationType.adjective() = _Adjective;

  const factory TranslationType.noun() = _Noun;

  factory TranslationType.fromJson(Map<String, dynamic> json) =>
      _$TranslationTypeFromJson(json);
}

class TranslationTypeJsonConverter
    implements JsonConverter<TranslationType, Map<String, dynamic>> {
  const TranslationTypeJsonConverter();

  @override
  TranslationType fromJson(Map<String, dynamic> json) =>
      TranslationType.fromJson(json);

  @override
  Map<String, dynamic> toJson(TranslationType object) => object.toJson();
}
