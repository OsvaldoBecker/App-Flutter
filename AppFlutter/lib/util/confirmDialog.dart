import 'package:flutter/material.dart';

class ConfirmDialog {
  static show(BuildContext context, String message, Function function) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text(
              'Attention!',
              style: TextStyle(
                color: Colors.red,
              ),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton.icon(
                        icon: Icon(Icons.check_circle),
                        label: Text('Yes'),
                        onPressed: () {
                          function();
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 20),
                      ElevatedButton.icon(
                        icon: Icon(Icons.cancel),
                        label: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ])
              ],
            ),
          );
        });
  }
}
