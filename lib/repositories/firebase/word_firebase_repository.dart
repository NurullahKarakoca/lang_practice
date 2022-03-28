import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lang_practice/models/translation/translation.dart';
import 'package:lang_practice/models/word/word.dart';
import 'package:lang_practice/repositories/i_word_repository.dart';

class WordFirebaseRepository implements IWordRepository {
  final _wordCollection = FirebaseFirestore.instance
      .collection("words")
      .withConverter<Word>(
          fromFirestore: (snapshot, options) =>
              snapshot.exists ? Word.fromJson(snapshot.data()!) : Word(),
          toFirestore: (word, options) => word.toJson());

  @override
  Future<String> add(Word model) async {
    final document = await _wordCollection.add(model);
    return document.id;
  }

  @override
  Future<Word?> get(String id) async {
    final document = await _wordCollection.doc(id).get();
    return document.data();
  }

  @override
  Future<List<Word>> getAll() async {
    var documents = await _wordCollection.get();
    return documents.docs.map((e) => e.data()).toList();
  }

  @override
  Future<String> addTranslation(Translation translation) async {
    final translationDoc = await _wordCollection
        .doc(translation.wordId)
        .collection("translations")
        .add(translation.toJson());
    return translationDoc.id;
  }
}
