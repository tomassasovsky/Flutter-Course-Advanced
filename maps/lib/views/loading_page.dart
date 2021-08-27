part of 'views.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
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
    if (state == AppLifecycleState.resumed && await Permission.location.isGranted) {
      Navigator.pushReplacementNamed(context, 'map');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: checkGPSLocation(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data ?? ''),
            );
          }
          return Center(
            child: CircularProgressIndicator(strokeWidth: 3),
          );
        },
      ),
    );
  }

  Future<String?> checkGPSLocation(BuildContext context) async {
    try {
      final bool permissionGPS = await Permission.location.isGranted;
      final bool enabledGPS = await Geolocator.isLocationServiceEnabled();

      if (permissionGPS && enabledGPS) {
        Navigator.pushReplacement(context, navigateFadeIn(context, MapPage()));
      } else if (!permissionGPS) {
        throw Exception('GPS Access is denied');
      } else if (!enabledGPS) {
        throw Exception('GPS is disabled');
      }
    } catch (error) {
      return error.toString();
    }
  }
}
