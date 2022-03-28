import 'package:get_it/get_it.dart';
import 'package:lang_practice/blocs/translationform/translation_form_cubit.dart';
import 'package:lang_practice/blocs/wordform/word_form_cubit.dart';
import 'package:lang_practice/blocs/wordlist/word_list_cubit.dart';
import 'package:lang_practice/repositories/firebase/word_firebase_repository.dart';
import 'package:lang_practice/repositories/i_word_repository.dart';

final injector = GetIt.asNewInstance();

Future initInjector() async {
  injector.registerFactory<IWordRepository>(() => WordFirebaseRepository());

  injector.registerFactory<WordListCubit>(() => WordListCubit(injector()));
  injector.registerFactory<WordFormCubit>(() => WordFormCubit(injector()));
  injector.registerFactory<TranslationFormCubit>(
      () => TranslationFormCubit(injector()));
}
