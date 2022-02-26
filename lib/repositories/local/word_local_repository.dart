import 'dart:async';

import 'package:lang_practice/models/word/word.dart';
import 'package:lang_practice/repositories/i_word_repository.dart';
import 'package:lang_practice/repositories/local/hive_mixin.dart';

class WordLocalRepository extends IWordRepository with HiveMixin {
  static const boxName = "words";

  @override
  Future<List<Word>> getWords() async => execBox<Word, List<Word>>(
      boxName: boxName, body: (box) => Future.sync(() => box.values.toList()));

  @override
  Future<int> addWord(Word newWord) =>
      execBox<Word, int>(boxName: boxName, body: (box) => box.add(newWord));
}
