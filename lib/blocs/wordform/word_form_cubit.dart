import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:lang_practice/inputs/word_title_input.dart';
import 'package:lang_practice/inputs/word_translation_input.dart';
import 'package:lang_practice/models/word/word.dart';
import 'package:lang_practice/repositories/i_word_repository.dart';

part 'word_form_state.dart';

class WordFormCubit extends Cubit<WordFormState> {
  final IWordRepository _wordRepository;

  WordFormCubit(this._wordRepository) : super(const WordFormState._());

  void onWordTitleInputChange(String value) {
    final wordTitleInput = WordTitleInput.dirty(value);
    emit(state.copyWith(
        wordTitleInput: wordTitleInput,
        status: Formz.validate([wordTitleInput, state.wordTranslationInput])));
  }

  void onWordTranslationInputChange(String value) {
    final wordTranslationInput = WordTranslationInput.dirty(value);
    emit(state.copyWith(
        wordTranslationInput: wordTranslationInput,
        status: Formz.validate([state.wordTitleInput, wordTranslationInput])));
  }

  void onFormSubmitted() async {
    if (state.status.isValidated) {
      final newWord = Word(
          title: state.wordTitleInput.value,
          translation: state.wordTranslationInput.value);
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      var id = await _wordRepository.addWord(newWord);
      if (id > 0) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
