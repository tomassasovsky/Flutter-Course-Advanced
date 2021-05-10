import 'package:band_names/services/server.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  online,
  offline,
  connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io(server, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    this._socket.on(('connect'), (_) {
      this._serverStatus = ServerStatus.online;
      notifyListeners();
    });

    this._socket.on(('disconnect'), (_) {
      this._serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    // _socket.on(('new-message'), (payload) {
    //   print('new-message:');
    //   print('name: ' + payload['name']);
    //   print(payload.containsKey('message') ? 'message: ' + payload['message'] : 'No message');
    // });
  }

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;
}
