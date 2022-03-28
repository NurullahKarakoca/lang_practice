import 'package:lang_practice/models/translation/translation.dart';
import 'package:lang_practice/models/word/word.dart';
import 'package:lang_practice/repositories/i_base_repository.dart';

abstract class IWordRepository extends IBaseRepository<Word> {
  Future<String> addTranslation(Translation translation);
}
