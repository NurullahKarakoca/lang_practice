import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lang_practice/repositories/i_word_repository.dart';

import '../../models/word/word.dart';

part 'word_list_cubit.freezed.dart';

part 'word_list_state.dart';

class WordListCubit extends Cubit<WordListState> {
  final IWordRepository _wordRepository;

  StreamSubscription? wordStreamSubs;

  WordListCubit(this._wordRepository) : super(const _Initial()) {
    // _wordRepository.watch().then((value) {
    //   wordStreamSubs = value.listen((event) {
    //     getWordList();
    //   });
    // });
  }

  @override
  Future<void> close() {
    wordStreamSubs?.cancel();
    return super.close();
  }

  Future getWordList() async {
    emit(const _Loading());
    try {
      var words = await _wordRepository.getAll();
      emit(_Loaded(words: words));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
