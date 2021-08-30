import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps/bloc/bloc.dart';
import 'package:maps/views/views.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => MapBloc()),
        BlocProvider(create: (context) => SearchBloc()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
