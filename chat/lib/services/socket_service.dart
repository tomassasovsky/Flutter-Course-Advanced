import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat/global/enviroment.dart';
import 'package:chat/services/auth_service.dart';

enum ServerStatus {
  online,
  offline,
  connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  void connect() async {
    final token = await AuthService.getToken();
    this._socket = IO.io(
      Enviroment.socketUrl,
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'forceNew': true,
        'extraHeaders': {'x-token': token}
      },
    );

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

  void disconnect() {
    this._socket.disconnect();
  }

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;
}
