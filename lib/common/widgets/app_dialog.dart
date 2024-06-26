import 'package:fluttertoast/fluttertoast.dart';

class AppDialog {
  static void showToast(String? msg, {Toast? length = Toast.LENGTH_SHORT, }) {
    Fluttertoast.showToast(
      msg: msg ?? "",
      toastLength: length,
      gravity: ToastGravity.TOP
    );
  }
}
