import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lang_practice/inputs/word_title_input.dart';
import 'package:lang_practice/models/word/word.dart';
import 'package:lang_practice/repositories/i_word_repository.dart';

part 'word_form_cubit.freezed.dart';

part 'word_form_state.dart';

class WordFormCubit extends Cubit<WordFormState> {
  final IWordRepository _wordRepository;

  WordFormCubit(this._wordRepository) : super(const WordFormState());

  void onWordTitleInputChange(String value) {
    final wordTitleInput = WordTitleInput.dirty(value);
    emit(state.copyWith(
        wordTitleInput: wordTitleInput,
        status: Formz.validate([wordTitleInput])));
  }

  void onFormSubmitted() async {
    if (state.status.isValidated) {
      final newWord = Word(title: state.wordTitleInput.value);
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        var id = await _wordRepository.add(newWord);
        emit(state.copyWith(
            newWord: newWord.copyWith(wordId: id),
            status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
