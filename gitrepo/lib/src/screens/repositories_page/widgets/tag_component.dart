import 'package:flutter/material.dart';

class TagComponent extends StatelessWidget {
  const TagComponent({Key key, this.tag, this.onTagPressed}) : super(key: key);

  final String tag;
  final VoidCallback onTagPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTagPressed,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '#$tag',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.clear,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
