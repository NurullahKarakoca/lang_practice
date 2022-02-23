import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_practice/blocs/word_list_cubit.dart';
import 'package:lang_practice/injector.dart';
import 'package:lang_practice/screens/words_screen.dart';

class AppRoutes {
  static const routeWords = "/words";

  static MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeWords:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => injector<WordListCubit>()..getWordList(),
                child: const WordsScreen()));
      default:
        return null;
    }
  }
}
