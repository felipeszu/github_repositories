import 'package:flutter/material.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_bloc.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_event.dart';
import 'package:gitrepo/src/screens/repositories_page/widgets/list_repository.dart';
import 'package:gitrepo/src/settings.dart';

class RepositoriesPage extends StatefulWidget {
  const RepositoriesPage({Key key, this.onPressed}) : super(key: key);
  final VoidCallback onPressed;
  @override
  _RepositoriesPageState createState() => _RepositoriesPageState();
}

class _RepositoriesPageState extends State<RepositoriesPage> {
  TextEditingController _textSearchTagController;
  RepositoriesBloc _repositoriesBloc;

  @override
  void initState() {
    _repositoriesBloc = getItInstance<RepositoriesBloc>()
      ..add(LoadRepositoriesPage());
    _textSearchTagController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: widget.onPressed,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            tagFormField(),
            Expanded(
                child: ListRepository(
              repositoriesBloc: _repositoriesBloc,
            )),
          ],
        ),
      ),
    );
  }

  Widget tagFormField() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textSearchTagController,
              decoration: InputDecoration(hintText: 'Search by tag'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _repositoriesBloc
                  .add(SearchRepositoriesByTag(_textSearchTagController.text));
            },
          )
        ],
      ),
    );
  }
}
