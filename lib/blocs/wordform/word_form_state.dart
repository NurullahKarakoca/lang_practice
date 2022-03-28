part of 'word_form_cubit.dart';

@freezed
class WordFormState with _$WordFormState {
  const factory WordFormState({
    @Default(WordTitleInput.pure()) WordTitleInput wordTitleInput,
    Word? newWord,
    @Default(FormzStatus.pure) FormzStatus status,
  }) = _WordFormState;
}
