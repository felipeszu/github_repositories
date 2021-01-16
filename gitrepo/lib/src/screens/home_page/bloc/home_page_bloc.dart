import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitrepo/src/models/repository.dart';
import 'package:gitrepo/src/repositories/home_repository/home_repository.dart';
import 'home_page_event.dart';
import 'home_page_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  HomeBloc(
    this._homeRepository,
  ) : super(HomeState.initial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadInitialHomeData) {
      yield* _mapLoadInitialHomeData();
    }
    if (event is SearchRepositories) {
      yield* _mapsearchRepository(event.username);
    }
    if (event is ClearRepositoryData) {
      yield* _mapClearRepositoryData();
    }
  }

  Stream<HomeState> _mapLoadInitialHomeData() async* {
    yield state.copyWith(loading: true);
    Repositories repositories = _homeRepository.getRepositoriesInRepoBox;
    if (repositories != null) {
      yield state.copyWith(loading: false, repositories: repositories);
      return;
    }
    yield state.copyWith(loading: false);
  }

  Stream<HomeState> _mapsearchRepository(String username) async* {
    yield state.copyWith(loading: true, error: '');
    try {
      Repositories repositories =
          await _homeRepository.getGitRepositoriesByUsername(username);
      _homeRepository.setRepositoriesInRepoBox(repositories);
      yield state.copyWith(loading: false, repositories: repositories);
    } catch (e) {
      if (e is DioError) {
        yield state.copyWith(
          error: '${e.response.statusCode} ${e.response.data['message']}',
          loading: false,
        );
      }
    }
  }

  Stream<HomeState> _mapClearRepositoryData() async* {
    yield state.copyWith(loading: true);
    await _homeRepository.clearRepoBox();
    Repositories repositories = _homeRepository.getRepositoriesInRepoBox;
    if (repositories == null) {
      yield HomeState.initial();
    }
  }
}
