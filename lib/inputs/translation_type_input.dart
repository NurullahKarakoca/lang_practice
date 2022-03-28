import 'package:formz/formz.dart';
import 'package:lang_practice/core/values/string.dart';
import 'package:lang_practice/models/translation/translation.dart';

enum TranslationTypeInputError { empty }

extension WordInputErrorMembers on TranslationTypeInputError {
  String? get message =>
      {TranslationTypeInputError.empty: AppStrings.requiredFieldMessage}[this];
}

class TranslationTypeInput
    extends FormzInput<TranslationType, TranslationTypeInputError> {
  const TranslationTypeInput.pure() : super.pure(const TranslationType.none());

  const TranslationTypeInput.dirty(TranslationType value) : super.dirty(value);

  @override
  TranslationTypeInputError? validator(TranslationType value) =>
      value == const TranslationType.none()
          ? TranslationTypeInputError.empty
          : null;
}
