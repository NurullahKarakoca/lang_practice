import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lang_practice/repositories/i_word_repository.dart';

import '../../models/word/word.dart';

part 'word_list_state.dart';

class WordListCubit extends Cubit<WordListState> {
  final IWordRepository _wordRepository;
  WordListCubit(this._wordRepository) : super(const WordListState.initial());

  Future getWordList() async {
    var words = await _wordRepository.getWords();
    emit(state.copyWith(status: WordListStatus.success, words: words));
  }
}
