import 'package:equatable/equatable.dart';

abstract class RepositoriesEvent extends Equatable {
  const RepositoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadRepositoriesPage extends RepositoriesEvent {}

class AddTagToRepository extends RepositoriesEvent {
  AddTagToRepository(this.repositoryId, this.tag);
  final int repositoryId;
  final String tag;
}

class SearchRepositoriesByTag extends RepositoriesEvent {
  SearchRepositoriesByTag(this.tag);
  final String tag;
}

class DeleteTagFromRepository extends RepositoriesEvent {
  DeleteTagFromRepository(this.tag, this.repositoryId);
  final String tag;
  final int repositoryId;
}
