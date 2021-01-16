import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitrepo/src/repositories/home_repository/home_repository.dart';
import 'package:gitrepo/src/screens/home_page/bloc/home_page_bloc.dart';
import 'package:gitrepo/src/screens/home_page/bloc/home_page_event.dart';
import 'package:gitrepo/src/screens/home_page/bloc/home_page_state.dart';
import 'package:mockito/mockito.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

main() async {
  HomeBloc homeBloc;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    homeBloc = HomeBloc(mockHomeRepository);
  });

  tearDown(() {
    homeBloc?.close();
  });

  group('Teste Group', () {
    blocTest<HomeBloc, HomeState>(
      'Empty Call',
      build: () => HomeBloc(mockHomeRepository),
      expect: [],
    );
    blocTest<HomeBloc, HomeState>(
      'Verifing Search Repositories',
      build: () => homeBloc,
      act: (bloc) => bloc.add(SearchRepositories('felipeszu')),
      verify: (_) {
        verify(mockHomeRepository.getGitRepositoriesByUsername('felipeszu'))
            .called(1);
        verify(mockHomeRepository.setRepositoriesInRepoBox(any)).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Empty Call',
      build: () => homeBloc,
      act: (bloc) => bloc.add(ClearRepositoryData()),
      // expect: [
      //   HomeState(loading: true, error: '', repositories: null),
      //   HomeState(loading: false, error: '', repositories: null),
      // ],
      verify: (_) {
        verify(mockHomeRepository.clearRepoBox()).called(1);
        verify(mockHomeRepository.getRepositoriesInRepoBox).called(1);
      },
    );
  });
}
