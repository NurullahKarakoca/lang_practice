import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';

part 'word.g.dart';

@freezed
class Word with _$Word {
  factory Word({required String title, required String translation}) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
