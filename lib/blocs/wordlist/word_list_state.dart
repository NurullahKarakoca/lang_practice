part of 'word_list_cubit.dart';

@freezed
class WordListState with _$WordListState {

  const factory WordListState.initial() = _Initial;

  const factory WordListState.loaded({@Default([]) List<Word> words}) = _Loaded;

  const factory WordListState.loading() = _Loading;

  const factory WordListState.error(String errorMessage) = _Error;
}
