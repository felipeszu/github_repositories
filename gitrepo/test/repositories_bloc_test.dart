import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitrepo/src/models/repository.dart';
import 'package:gitrepo/src/models/tag.dart';
import 'package:gitrepo/src/repositories/home_repository/home_repository.dart';
import 'package:gitrepo/src/repositories/tag_repository/tag_repository.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_bloc.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_event.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_state.dart';
import 'package:mockito/mockito.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockTagRepository extends Mock implements TagRepository {}

main() async {
  RepositoriesBloc repositoriesBloc;
  MockHomeRepository mockHomeRepository;
  MockTagRepository mockTagRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockTagRepository = MockTagRepository();
    repositoriesBloc = RepositoriesBloc(mockTagRepository, mockHomeRepository);
  });

  tearDown(() {
    repositoriesBloc?.close();
  });

  group('Teste Group', () {
    List<Repository> repositories = [
      Repository(
        id: 1,
        name: 'Some Name One',
        description: 'A simple descriptions',
      ),
      Repository(),
    ];
    blocTest<RepositoriesBloc, RepositoriesState>(
      'Empty Call',
      build: () => RepositoriesBloc(mockTagRepository, mockHomeRepository),
      expect: [],
    );
    blocTest<RepositoriesBloc, RepositoriesState>(
      'Add Tag To repository',
      build: () {
        when(repositoriesBloc.refreshRepositoryListWithTags(repositories))
            .thenAnswer((_) => repositories);
        return repositoriesBloc;
      },
      act: (bloc) => bloc.add(AddTagToRepository(1, 'tag')),
      expect: [
        RepositoriesState(loading: true, error: '', repositories: null),
        RepositoriesState(loading: false, error: '', repositories: null),
      ],
      verify: (_) {
        verify(mockTagRepository.saveRepositoryTag(1, 'tag')).called(1);
      },
    );
    blocTest<RepositoriesBloc, RepositoriesState>(
      'Delete Tag',
      build: () {
        when(mockTagRepository.deleteTag(1, 'tag'))
            .thenAnswer((_) async => Tag(idRepository: 1, tags: []));
        when(mockHomeRepository.getRepositoriesInRepoBox)
            .thenAnswer((_) => Repositories(repositories: repositories));

        Repositories repo = mockHomeRepository.getRepositoriesInRepoBox;
        expect(repo.repositories, repositories);

        return repositoriesBloc;
      },
      act: (bloc) => bloc.add(DeleteTagFromRepository('tag', 1)),
      expect: [
        RepositoriesState(loading: true, error: '', repositories: null),
        RepositoriesState(loading: false, error: '', repositories: null),
      ],
      verify: (_) {
        verify(mockTagRepository.deleteTag(1, 'tag')).called(1);
        verify(mockHomeRepository.getRepositoriesInRepoBox).called(1);
      },
    );
  });
}
