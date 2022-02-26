part of 'word_form_cubit.dart';

class WordFormState extends Equatable {
  final WordTitleInput wordTitleInput;
  final WordTranslationInput wordTranslationInput;
  final FormzStatus status;

  const WordFormState._(
      {this.wordTitleInput = const WordTitleInput.pure(),
      this.wordTranslationInput = const WordTranslationInput.pure(),
      this.status = FormzStatus.pure});

  const WordFormState.initial() : this._();

  WordFormState copyWith(
          {WordTitleInput? wordTitleInput,
          WordTranslationInput? wordTranslationInput,
          FormzStatus? status}) =>
      WordFormState._(
          wordTitleInput: wordTitleInput ?? this.wordTitleInput,
          wordTranslationInput:
              wordTranslationInput ?? this.wordTranslationInput,
          status: status ?? this.status);

  @override
  List<Object> get props => [wordTitleInput, wordTranslationInput, status];
}
