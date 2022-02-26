import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lang_practice/blocs/wordform/word_form_cubit.dart';
import 'package:lang_practice/core/values/dimen.dart';
import 'package:lang_practice/core/values/string.dart';
import 'package:lang_practice/inputs/word_title_input.dart';
import 'package:lang_practice/inputs/word_translation_input.dart';

class WordFormScreen extends StatefulWidget {
  const WordFormScreen({Key? key}) : super(key: key);

  @override
  _WordFormScreenState createState() => _WordFormScreenState();
}

class _WordFormScreenState extends State<WordFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.wordFormTitle),
      ),
      body: const _WordForm(),
    );
  }
}

class _WordForm extends StatefulWidget {
  const _WordForm({Key? key}) : super(key: key);

  @override
  _WordFormState createState() => _WordFormState();
}

class _WordFormState extends State<_WordForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WordFormCubit, WordFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(AppStrings.newWordSubmissionInProgress)));
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(AppStrings.newWordSubmissionError)));
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(AppStrings.newWordSubmissionSuccess)));
          Navigator.pop(context, true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.space),
        child: Column(
          children: const [
            _WordTitleInput(),
            _WordTranslationInput(),
            SizedBox(
              height: AppDimens.space,
            ),
            _SubmitButton()
          ],
        ),
      ),
    );
  }
}

class _WordTitleInput extends StatelessWidget {
  const _WordTitleInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordFormCubit, WordFormState>(
      builder: (context, state) {
        var error = state.wordTitleInput.error?.message;
        return TextFormField(
          initialValue: state.wordTitleInput.value,
          decoration: InputDecoration(
              labelText: AppStrings.wordTitleLabel, errorText: error),
          onChanged: (value) {
            context.read<WordFormCubit>().onWordTitleInputChange(value);
          },
        );
      },
    );
  }
}

class _WordTranslationInput extends StatelessWidget {
  const _WordTranslationInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordFormCubit, WordFormState>(
      builder: (context, state) {
        var error = state.wordTranslationInput.error?.message;
        return TextFormField(
          initialValue: state.wordTranslationInput.value,
          decoration: InputDecoration(
              labelText: AppStrings.wordTranslationLabel, errorText: error),
          onChanged: (value) {
            context.read<WordFormCubit>().onWordTranslationInputChange(value);
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {
              context.read<WordFormCubit>().onFormSubmitted();
            },
            child: const Text(AppStrings.add)));
  }
}
