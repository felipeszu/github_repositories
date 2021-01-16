import 'package:dio/dio.dart';
import 'package:gitrepo/src/common/box_repository.dart';
import 'package:gitrepo/src/models/repository.dart';
import 'package:gitrepo/src/repositories/home_repository/home_repository_urls.dart';

class HomeRepository {
  HomeRepository(this._api, this._boxRepository);
  Dio _api;
  BoxRepository _boxRepository;

  Future<Repositories> getGitRepositoriesByUsername(String username) async {
    Response response =
        await _api.get(HomeRepositoryUrls.gitReposByUsername(username));
    return Repositories.fromJson(response.data);
  }

  Future setRepositoriesInRepoBox(Repositories repositories) async {
    await _boxRepository.repoBox.put('REPOSITORIES', repositories);
  }

  Repositories get getRepositoriesInRepoBox =>
      _boxRepository.repoBox.get('REPOSITORIES');

  Future<void> clearRepoBox() async {
    await _boxRepository.repoBox.delete('REPOSITORIES');
  }

  Future<void> clearAllRepoBox() async {
    await _boxRepository.repoBox.clear();
  }
}
