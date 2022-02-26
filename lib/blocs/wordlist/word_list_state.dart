part of 'word_list_cubit.dart';

enum WordListStatus { loading, success, failure }

class WordListState extends Equatable {
  final WordListStatus status;
  final List<Word> words;

  bool get isLoading => status == WordListStatus.loading;

  bool get isSuccess => status == WordListStatus.success;

  bool get isFailure => status == WordListStatus.failure;

  const WordListState._(
      {this.status = WordListStatus.loading, this.words = const []});

  const WordListState.initial() : this._();

  copyWith({List<Word>? words, WordListStatus? status}) => WordListState._(
      words: words ?? this.words, status: status ?? this.status);

  @override
  List<Object> get props => [words, status];
}
