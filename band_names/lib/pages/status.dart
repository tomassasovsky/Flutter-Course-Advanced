import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:band_names/services/services.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Server Status: ${socketService.serverStatus}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          socketService.emit(
            'new-message',
            {'name': 'Flutter', 'message': 'Hello Flutter!'},
          );
        },
      ),
    );
  }
}
