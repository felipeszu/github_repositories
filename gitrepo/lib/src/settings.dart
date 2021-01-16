import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gitrepo/src/repositories/home_repository/home_repository.dart';
import 'package:gitrepo/src/repositories/tag_repository/tag_repository.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'common/box_repository.dart';
import 'models/repository.dart';
import 'models/tag.dart';
import 'screens/home_page/bloc/home_page_bloc.dart';

GetIt getItInstance = GetIt.instance;
Dio apiCaller = Dio();

enum boxes { repoBox }

Future setup() async {
  getItInstance.allowReassignment = true;
  BoxRepository _boxes = await _setupHive();
  _registerServices(_boxes);
  _registerBlocs(_boxes);
}

void _registerServices(BoxRepository _boxes) {
  getItInstance.registerLazySingleton(() => HomeRepository(apiCaller, _boxes));
  getItInstance.registerLazySingleton(() => TagRepository(_boxes));
}

void _registerBlocs(BoxRepository _boxes) {
  getItInstance.registerLazySingleton<HomeBloc>(
    () => HomeBloc(getItInstance()),
  );

  getItInstance.registerLazySingleton<RepositoriesBloc>(
    () => RepositoriesBloc(getItInstance(), getItInstance()),
  );
}

Future<BoxRepository> _setupHive() async {
  final dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(RepositoryAdapter());
  Hive.registerAdapter(RepositoriesAdapter());
  Hive.registerAdapter(TagAdapter());

  final _boxes = await _openAllBoxes();
  return _boxes;
}

Future<BoxRepository> _openAllBoxes() async {
  var repoBox = await Hive.openBox(boxes.repoBox.toString());

  return BoxRepository(
    repoBox: repoBox,
  );
}
