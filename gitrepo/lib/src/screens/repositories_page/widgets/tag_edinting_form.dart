import 'package:flutter/material.dart';

class TagEditingForm extends StatelessWidget {
  const TagEditingForm({
    Key key,
    @required this.textAddTagController,
    @required this.onButtonPressed,
    @required this.tags,
  }) : super(key: key);

  final TextEditingController textAddTagController;
  final VoidCallback onButtonPressed;
  final List<Widget> tags;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: tags,
        ),
        TextField(
          controller: textAddTagController,
          decoration: InputDecoration(hintText: 'Write a Tag name'),
        ),
        RaisedButton(
          child: Text('Salvar'),
          onPressed: onButtonPressed,
        )
      ],
    );
  }
}
