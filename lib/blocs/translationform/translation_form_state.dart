part of 'translation_form_cubit.dart';

@freezed
class TranslationFormState with _$TranslationFormState {
  const factory TranslationFormState(
      {@Default(TranslationTitleInput.pure()) TranslationTitleInput titleInput,
      @Default(TranslationTypeInput.pure()) TranslationTypeInput typeInput,
      @Default(FormzStatus.pure) FormzStatus status}) = _TranslationFormState;
}
