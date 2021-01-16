import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialHomeData extends HomeEvent {}

class SearchRepositories extends HomeEvent {
  SearchRepositories(this.username);
  final String username;
}

class ClearRepositoryData extends HomeEvent {}
