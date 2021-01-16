class HomeRepositoryUrls {
  static String gitReposByUsername(String userName) =>
      'https://api.github.com/users/$userName/repos';
}
