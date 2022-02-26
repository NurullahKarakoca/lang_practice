import 'package:formz/formz.dart';
import 'package:lang_practice/core/values/string.dart';

enum WordTranslationInputError { empty }

extension WordTranslationInputErrorMembers on WordTranslationInputError {
  String? get message =>
      {WordTranslationInputError.empty: AppStrings.requiredFieldMessage}[this];
}

class WordTranslationInput
    extends FormzInput<String, WordTranslationInputError> {
  const WordTranslationInput.pure() : super.pure('');

  const WordTranslationInput.dirty(String value) : super.dirty(value);

  @override
  WordTranslationInputError? validator(String value) =>
      value.isEmpty ? WordTranslationInputError.empty : null;
}
