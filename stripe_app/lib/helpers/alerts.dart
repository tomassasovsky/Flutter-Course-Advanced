part of 'helpers.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Loading...'),
        content: LinearProgressIndicator(),
      );
    },
  );
}

showAlert(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          MaterialButton(
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
