import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitrepo/src/models/repository.dart';
import 'package:gitrepo/src/models/tag.dart';
import 'package:gitrepo/src/repositories/home_repository/home_repository.dart';
import 'package:gitrepo/src/repositories/tag_repository/tag_repository.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_event.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_state.dart';

class RepositoriesBloc extends Bloc<RepositoriesEvent, RepositoriesState> {
  RepositoriesBloc(this._tagRepository, this._homeRepository)
      : super(RepositoriesState.initial());
  TagRepository _tagRepository;
  HomeRepository _homeRepository;

  @override
  Stream<RepositoriesState> mapEventToState(RepositoriesEvent event) async* {
    if (event is LoadRepositoriesPage) {
      yield* _mapLoadRepositoriesPage();
    }

    if (event is AddTagToRepository) {
      yield* _mapAddTagToRepository(event.repositoryId, event.tag);
    }

    if (event is SearchRepositoriesByTag) {
      yield* _mapSearchRepositoriesByTag(event.tag);
    }

    if (event is DeleteTagFromRepository) {
      yield* _mapDeleteTagFromRepository(event.tag, event.repositoryId);
    }
  }

  Stream<RepositoriesState> _mapLoadRepositoriesPage() async* {
    Repositories repositories = _homeRepository.getRepositoriesInRepoBox;
    yield state.copyWith(
      repositories: refreshRepositoryListWithTags(repositories.repositories),
      loading: false,
    );
  }

  Stream<RepositoriesState> _mapAddTagToRepository(
      int repositoryId, String tag) async* {
    yield state.copyWith(loading: true);
    await _tagRepository.saveRepositoryTag(repositoryId, tag);
    yield state.copyWith(
      loading: false,
      repositories: refreshRepositoryListWithTags(state.repositories),
    );
  }

  Stream<RepositoriesState> _mapSearchRepositoriesByTag(String tag) async* {
    yield state.copyWith(loading: true);
    yield* _mapLoadRepositoriesPage();
    if (tag.isNotEmpty) {
      List<Repository> repositories = state.repositories.where((repository) {
        return repository.tag?.tags?.contains(tag) == true;
      }).toList();
      yield state.copyWith(loading: false, repositories: repositories);
    }
  }

  Stream<RepositoriesState> _mapDeleteTagFromRepository(
    String tag,
    int repositoryId,
  ) async* {
    yield state.copyWith(loading: true);

    await _tagRepository.deleteTag(repositoryId, tag);
    List<Repository> repositories =
        refreshRepositoryListWithTags(state.repositories);
    yield state.copyWith(
      loading: false,
      repositories: repositories,
    );
  }

  List<Repository> refreshRepositoryListWithTags(
      List<Repository> repositories) {
    repositories?.forEach((repository) {
      Tag tag = _tagRepository.findSomerepository(repository.id);
      if (tag != null) {
        repository.tag = tag;
      }
    });
    return repositories;
  }
}
