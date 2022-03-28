import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_practice/blocs/translationform/translation_form_cubit.dart';
import 'package:lang_practice/blocs/wordform/word_form_cubit.dart';
import 'package:lang_practice/blocs/wordlist/word_list_cubit.dart';
import 'package:lang_practice/injector.dart';
import 'package:lang_practice/models/word/word.dart';
import 'package:lang_practice/screens/translation_form_screen.dart';
import 'package:lang_practice/screens/word_form_screen.dart';
import 'package:lang_practice/screens/words_screen.dart';

class AppRoutes {
  static const routeWords = "/words";
  static const routeWordForm = "/wordform";
  static const routeTranslationForm = "/translationform";

  static MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeWords:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => injector<WordListCubit>()..getWordList(),
                child: const WordsScreen()));
      case routeWordForm:
        return MaterialPageRoute<bool>(
            builder: (context) => BlocProvider(
                create: (context) => injector<WordFormCubit>(),
                child: const WordFormScreen()));
      case routeTranslationForm:
        final word = settings.arguments as Word;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      injector<TranslationFormCubit>()..setWord(word),
                  child: const TranslationFormScreen(),
                ));
      default:
        return null;
    }
  }
}
