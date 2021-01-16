import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_bloc.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_event.dart';
import 'package:gitrepo/src/screens/repositories_page/bloc/repositories_state.dart';
import 'package:gitrepo/src/screens/repositories_page/widgets/tag_component.dart';
import 'package:gitrepo/src/screens/repositories_page/widgets/tag_edinting_form.dart';
import '../../../utils/extensions.dart';

class ListRepository extends StatefulWidget {
  final RepositoriesBloc repositoriesBloc;

  const ListRepository({Key key, this.repositoriesBloc}) : super(key: key);
  @override
  _ListRepositoryState createState() => _ListRepositoryState();
}

class _ListRepositoryState extends State<ListRepository> {
  TextEditingController _addTagEditingController;

  @override
  void initState() {
    _addTagEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: widget.repositoriesBloc,
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.repositories?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    attributesRows(
                      'Repository',
                      state.repositories[index].name,
                    ),
                    SizedBox(height: 14),
                    attributesRows(
                        'Language',
                        state.repositories[index].language ??
                            'Language not available'),
                    SizedBox(height: 14),
                    attributesColumn(
                      'Description',
                      value: state.repositories[index].description ??
                          'No description available',
                    ),
                    SizedBox(height: 14),
                    attributesColumn(
                      'Tags',
                      child: Wrap(
                        children: tags(state: state, index: index),
                      ),
                      onPressed: () {
                        context.showSnackBar(
                          child: TagEditingForm(
                            textAddTagController: _addTagEditingController,
                            tags: tags(
                              state: state,
                              index: index,
                              closeAfterDelete: true,
                            ),
                            onButtonPressed: () {
                              if (_addTagEditingController.text.isNotEmpty) {
                                widget.repositoriesBloc.add(
                                  AddTagToRepository(
                                    state.repositories[index].id,
                                    _addTagEditingController.text.toLowerCase(),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> tags(
      {RepositoriesState state, int index, bool closeAfterDelete = false}) {
    if (state.repositories[index].tag != null) {
      return state.repositories[index].tag.tags
          .map((tag) => TagComponent(
                tag: tag,
                onTagPressed: () {
                  widget.repositoriesBloc.add(DeleteTagFromRepository(
                      tag, state.repositories[index].id));
                  if (closeAfterDelete) Navigator.pop(context);
                },
              ))
          .toList();
    }
    return [];
  }

  Widget attributesRows(String title, String value) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget attributesColumn(String title,
      {String value, Widget child, VoidCallback onPressed}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$title: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 7),
              child ??
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
            ],
          ),
        ),
        onPressed != null
            ? IconButton(
                icon: Icon(Icons.edit),
                onPressed: onPressed,
              )
            : SizedBox.shrink()
      ],
    );
  }
}
