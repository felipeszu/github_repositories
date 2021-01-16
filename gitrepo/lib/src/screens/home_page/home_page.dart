import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../settings.dart';
import 'bloc/home_page_bloc.dart';
import 'bloc/home_page_event.dart';
import 'bloc/home_page_state.dart';
import '../../utils/extensions.dart';
import '../repositories_page/repositories_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeBloc _homeBloc;
  TextEditingController _textEditingController;

  @override
  void initState() {
    _homeBloc = getItInstance<HomeBloc>()..add(LoadInitialHomeData());
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        cubit: _homeBloc,
        listener: (BuildContext context, HomeState state) {
          if (state.error.isNotEmpty)
            context.showSnackError(
              state.error,
            );
        },
        builder: (BuildContext context, HomeState state) {
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.repositories.repositories.isNotEmpty) {
            return RepositoriesPage(
              onPressed: () {
                _homeBloc.add(ClearRepositoryData());
              },
            );
          }
          return emptyHome();
        },
      ),
    );
  }

  Widget emptyHome() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Image.asset('assets/images/GITHUB-LOGO.png')),
            formBuilder()
          ],
        ),
      ),
    );
  }

  Widget formBuilder() {
    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    hintText: 'Search',
                    labelText: 'Insert your GitHub username:'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _homeBloc.add(SearchRepositories(_textEditingController.text));
              },
            ),
          ],
        ),
      ),
    );
  }
}
