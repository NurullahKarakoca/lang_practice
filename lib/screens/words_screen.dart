import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_practice/blocs/word_list_cubit.dart';
import 'package:lang_practice/core/values/dimen.dart';
import 'package:lang_practice/core/values/string.dart';
import 'package:lang_practice/models/word/word.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({Key? key}) : super(key: key);

  @override
  _WordsScreenState createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.wordsTitle),
      ),
      body: const _WordList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _WordList extends StatefulWidget {
  const _WordList({Key? key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<_WordList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WordListCubit, WordListState>(
        listener: (context, state) {
      if (state.isFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Bir hata oluştu")));
      }
    }, builder: (context, state) {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      var words = state.words;
      if (words.isEmpty) return const _WordEmptyList();

      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: words.length,
        itemBuilder: (context, index) => _WordListItem(word: words[index]),
        separatorBuilder: (context, index) => const SizedBox(
          height: AppDimens.space,
        ),
      );
    });
  }
}

class _WordListItem extends StatelessWidget {
  final Word word;

  const _WordListItem({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      word.title,
    );
  }
}

class _WordEmptyList extends StatelessWidget {
  const _WordEmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Please, add new word"),
    );
  }
}
