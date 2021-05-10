import 'package:flutter/cupertino.dart';

import 'package:chat/pages/pages.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'users':
      return CupertinoPageRoute(builder: (_) => UsersPage(), settings: settings);
    case 'chat':
      return CupertinoPageRoute(builder: (_) => ChatPage(), settings: settings);
    case 'loading':
      return CupertinoPageRoute(builder: (_) => LoadingPage(), settings: settings);
    case 'register':
      return CupertinoPageRoute(builder: (_) => RegisterPage(), settings: settings);
    case 'login':
      return CupertinoPageRoute(builder: (_) => LoginPage(), settings: settings);
    default:
      return CupertinoPageRoute(builder: (_) => UsersPage(), settings: settings);
  }
}
