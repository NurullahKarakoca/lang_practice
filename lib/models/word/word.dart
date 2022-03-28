import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lang_practice/models/translation/translation.dart';

part 'word.freezed.dart';

part 'word.g.dart';

@freezed
class Word with _$Word {
  factory Word(
      {@Default("") String title,
      @JsonKey(ignore: true) String? wordId,
      @JsonKey(ignore: true) List<Translation>? translations}) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
