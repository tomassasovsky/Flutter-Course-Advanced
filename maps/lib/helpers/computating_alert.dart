part of 'helpers.dart';

void computatingAlert(BuildContext context) {
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
