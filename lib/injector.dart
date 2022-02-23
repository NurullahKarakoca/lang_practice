import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lang_practice/blocs/word_list_cubit.dart';
import 'package:lang_practice/repositories/i_word_repository.dart';
import 'package:lang_practice/repositories/local/word_local_repository.dart';

final injector = GetIt.asNewInstance();

Future initInjector() async {
  await Hive.initFlutter();

  injector.registerFactory<IWordRepository>(() => WordLocalRepository());
  injector.registerFactory<WordListCubit>(() => WordListCubit(injector()));
}
