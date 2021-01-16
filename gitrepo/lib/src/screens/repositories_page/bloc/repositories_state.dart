import 'package:equatable/equatable.dart';
import 'package:gitrepo/src/models/repository.dart';

class RepositoriesState extends Equatable {
  final bool loading;
  final String error;
  final List<Repository> repositories;

  RepositoriesState({
    this.loading,
    this.error,
    this.repositories,
  });

  factory RepositoriesState.initial() {
    return RepositoriesState(
      loading: true,
      error: '',
    );
  }

  RepositoriesState copyWith({
    bool loading,
    String error,
    List<Repository> repositories,
  }) {
    return RepositoriesState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      repositories: repositories ?? this.repositories,
    );
  }

  Map<String, dynamic> toJson() => {
        "loading": this.loading,
        "error": this.error,
        "repositories": this.repositories,
      };

  @override
  List<Object> get props => [loading, error, repositories];
}
