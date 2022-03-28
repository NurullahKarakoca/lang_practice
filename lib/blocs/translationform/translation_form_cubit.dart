import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lang_practice/inputs/translation_title_input.dart';
import 'package:lang_practice/inputs/translation_type_input.dart';
import 'package:lang_practice/models/translation/translation.dart';
import 'package:lang_practice/models/word/word.dart';
import 'package:lang_practice/repositories/i_word_repository.dart';

part 'translation_form_cubit.freezed.dart';

part 'translation_form_state.dart';

class TranslationFormCubit extends Cubit<TranslationFormState> {
  final IWordRepository _wordRepository;
  late Word word;

  TranslationFormCubit(this._wordRepository)
      : super(const TranslationFormState());

  Future<void> setWord(Word word) async {
    this.word = word;
  }

  void onChangedTitle(String value) {
    final titleInput = TranslationTitleInput.dirty(value);
    emit(state.copyWith(
        titleInput: titleInput,
        status: Formz.validate([titleInput, state.typeInput])));
  }

  void onChangedType(TranslationType? type) {
    final typeInput =
        TranslationTypeInput.dirty(type ?? const TranslationType.none());
    emit(state.copyWith(
        typeInput: typeInput,
        status: Formz.validate([state.titleInput, typeInput])));
  }

  void onFormSubmitted() async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      var newTranslation = Translation(
          state.titleInput.value, state.typeInput.value,
          wordId: word.wordId);
      try {
        await _wordRepository.addTranslation(newTranslation);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
