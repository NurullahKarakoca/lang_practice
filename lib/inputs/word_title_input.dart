import 'package:formz/formz.dart';
import 'package:lang_practice/core/values/string.dart';

enum WordTitleInputError { empty }

extension WordInputErrorMembers on WordTitleInputError {
  String? get message =>
      {WordTitleInputError.empty: AppStrings.requiredFieldMessage}[this];
}

class WordTitleInput extends FormzInput<String, WordTitleInputError> {
  const WordTitleInput.pure() : super.pure('');

  const WordTitleInput.dirty(String value) : super.dirty(value);

  @override
  WordTitleInputError? validator(String value) =>
      value.isEmpty ? WordTitleInputError.empty : null;
}
