import 'package:lang_practice/models/word/word.dart';

abstract class IWordRepository {
  Future<List<Word>> getWords();
}
