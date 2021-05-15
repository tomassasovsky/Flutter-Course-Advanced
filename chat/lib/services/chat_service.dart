import 'package:chat/global/enviroment.dart';
import 'package:chat/models/message_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/user.dart';

class ChatService with ChangeNotifier {
  late User userFor;

  Future<List<Message>> getChat(String userID) async {
    final response = await http.get(
      Uri.parse('${Enviroment.apiUrl}/messages/$userID'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      },
    );

    final messagesResponse = messagesResponseFromJson(response.body);
    return messagesResponse.messages;
  }
}
