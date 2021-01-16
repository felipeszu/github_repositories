import 'package:flutter/material.dart';

class FeedbackBottomSheet extends StatelessWidget {
  final String message;
  final Color shadowColor;
  final Widget child;

  const FeedbackBottomSheet({
    Key key,
    this.message,
    this.shadowColor,
    this.child,
  }) : super(key: key);

  static show(BuildContext context,
      {String message, Color shadowColor, Widget child}) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      elevation: 0,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (builder) => FeedbackBottomSheet(
        message: message,
        child: child,
        shadowColor: shadowColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24) +
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.grey,
            offset: Offset(0, -8),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          child != null
              ? child
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Oops!',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
