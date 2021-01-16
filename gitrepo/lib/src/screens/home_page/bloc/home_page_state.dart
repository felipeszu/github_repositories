import 'package:equatable/equatable.dart';
import 'package:gitrepo/src/models/repository.dart';

class HomeState extends Equatable {
  final bool loading;
  final String error;
  final Repositories repositories;
  HomeState({
    this.loading,
    this.error,
    this.repositories,
  });

  factory HomeState.initial() {
    return HomeState(
      loading: false,
      error: '',
      repositories: Repositories.empty(),
    );
  }

  HomeState copyWith({
    bool loading,
    String error,
    Repositories repositories,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      repositories: repositories ?? this.repositories,
    );
  }

  Map<String, dynamic> toJson() => {
        "loading": this.loading,
        "error": this.error,
        "repositories": this.repositories.toJson(),
      };

  @override
  List<Object> get props => [
        loading,
        error,
        repositories,
      ];
}
