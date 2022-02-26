import 'package:hive/hive.dart';
import 'package:lang_practice/models/word/word.dart';

class WordTypeAdapter extends TypeAdapter<Word> {
  @override
  Word read(BinaryReader reader) => Word.fromJson(reader.readMap().cast());

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Word obj) {
    writer.writeMap(obj.toJson());
  }
}
