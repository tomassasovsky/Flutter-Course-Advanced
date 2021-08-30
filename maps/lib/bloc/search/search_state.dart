part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool manualSelection;
  final List<SearchResult> history;

  SearchState({
    this.manualSelection = false,
    this.history = const [],
  });

  SearchState copyWith({
    bool? manualSelection,
    List<SearchResult>? history,
  }) {
    return SearchState(
      manualSelection: manualSelection ?? this.manualSelection,
      history: history ?? this.history,
    );
  }
}
