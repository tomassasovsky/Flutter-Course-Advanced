part of 'views.dart';

class GPSAccessPage extends StatefulWidget {
  @override
  _GPSAccessPageState createState() => _GPSAccessPageState();
}

class _GPSAccessPageState extends State<GPSAccessPage> with WidgetsBindingObserver {
  bool popup = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && await Permission.location.isGranted && !popup) {
      Navigator.pushReplacementNamed(context, 'loading');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('GPS Access is required'),
            MaterialButton(
              child: Text('Ask for permission', style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async => await handleGPSPermission(context),
            ),
          ],
        ),
      ),
    );
  }

  handleGPSPermission(BuildContext context) async {
    popup = true;
    final PermissionStatus status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, 'loading');
        break;
      case PermissionStatus.denied:
        await Permission.location.request();
        break;
      default:
        await openAppSettings();
        break;
    }
    popup = false;
  }
}
