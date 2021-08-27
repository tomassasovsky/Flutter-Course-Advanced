import 'package:flutter/material.dart';
import 'package:maps/views/views.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'loading',
      onGenerateRoute: (RouteSettings? settings) {
        switch (settings?.name) {
          case 'loading':
            return MaterialPageRoute(builder: (_) => LoadingPage());
          case 'map':
            return MaterialPageRoute(builder: (_) => MapPage());
          case 'gps_access':
            return MaterialPageRoute(builder: (_) => GPSAccessPage());
        }
      },
    );
  }
}
