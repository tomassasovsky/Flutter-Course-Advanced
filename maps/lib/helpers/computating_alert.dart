part of 'helpers.dart';

computatingAlert(BuildContext context) async {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Computation in progress'),
          content: Text('Please wait...'),
        );
      },
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Computation in progress'),
          content: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
