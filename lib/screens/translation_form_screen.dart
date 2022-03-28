import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lang_practice/core/values/dimen.dart';
import 'package:lang_practice/core/values/string.dart';
import 'package:lang_practice/inputs/translation_title_input.dart';
import 'package:lang_practice/inputs/translation_type_input.dart';
import 'package:lang_practice/models/translation/translation.dart';

import '../blocs/translationform/translation_form_cubit.dart';

class TranslationFormScreen extends StatefulWidget {
  const TranslationFormScreen({Key? key}) : super(key: key);

  @override
  State<TranslationFormScreen> createState() => _TranslationFormScreenState();
}

class _TranslationFormScreenState extends State<TranslationFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.read<TranslationFormCubit>().word.title),
        ),
        body: const SafeArea(child: _TranslationForm()));
  }
}

class _TranslationForm extends StatefulWidget {
  const _TranslationForm({Key? key}) : super(key: key);

  @override
  State<_TranslationForm> createState() => _TranslationFormState();
}

class _TranslationFormState extends State<_TranslationForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TranslationFormCubit, TranslationFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(AppStrings.newTranslationSubmissionInProgress)));
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(AppStrings.newTranslationSubmissionError)));
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(AppStrings.newTranslationSubmissionSuccess)));
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.space),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _TitleInput(),
            SizedBox(
              height: AppDimens.space,
            ),
            _TypeDropDownButton(),
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

class _TitleInput extends StatelessWidget {
  const _TitleInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationFormCubit, TranslationFormState>(
      builder: (context, state) {
        final error = state.titleInput.error?.message;
        return TextFormField(
          initialValue: state.titleInput.value,
          decoration: InputDecoration(labelText: "Translate", errorText: error),
          onChanged: context.read<TranslationFormCubit>().onChangedTitle,
        );
      },
    );
  }
}

class _TypeDropDownButton extends StatelessWidget {
  const _TypeDropDownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = [
      const TranslationType.none(),
      const TranslationType.adjective(),
      const TranslationType.adverb(),
      const TranslationType.verb(),
      const TranslationType.noun()
    ]
        .map((type) => DropdownMenuItem<TranslationType>(
            value: type,
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.space),
              child: Text(type.map(
                  none: (_) => "Select a translation type",
                  verb: (_) => "Verb",
                  adverb: (_) => "Adverb",
                  adjective: (_) => "Adjective",
                  noun: (_) => "Noun")),
            )))
        .toList();

    return BlocBuilder<TranslationFormCubit, TranslationFormState>(
      builder: (context, state) {
        final error = state.typeInput.error?.message;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<TranslationType>(
                items: items,
                value: state.typeInput.value,
                onChanged: context.read<TranslationFormCubit>().onChangedType),
            if (error != null)
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              )
          ],
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
              context.read<TranslationFormCubit>().onFormSubmitted();
            },
            child: const Text(AppStrings.add)));
  }
}
