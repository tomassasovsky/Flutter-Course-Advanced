import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:band_names/pages/pages.dart';
import 'package:band_names/services/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'status':
              return CupertinoPageRoute(builder: (_) => StatusPage());
            case 'home':
              return CupertinoPageRoute(builder: (_) => HomePage());
            default:
              return CupertinoPageRoute(builder: (_) => HomePage());
          }
        },
      ),
    );
  }
}
