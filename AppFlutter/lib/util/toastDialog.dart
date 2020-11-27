import 'package:fluttertoast/fluttertoast.dart';

class ToastDialog {
  static show(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER);
  }
}
