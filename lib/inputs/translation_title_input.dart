import 'package:formz/formz.dart';
import 'package:lang_practice/core/values/string.dart';

enum TranslationTitleInputError { empty }

extension TranslationTitleErrorMembers on TranslationTitleInputError {
  String? get message =>
      {TranslationTitleInputError.empty: AppStrings.requiredFieldMessage}[this];
}

class TranslationTitleInput
    extends FormzInput<String, TranslationTitleInputError> {
  const TranslationTitleInput.pure() : super.pure('');

  const TranslationTitleInput.dirty(String value) : super.dirty(value);

  @override
  TranslationTitleInputError? validator(String value) =>
      value.isEmpty ? TranslationTitleInputError.empty : null;
}
