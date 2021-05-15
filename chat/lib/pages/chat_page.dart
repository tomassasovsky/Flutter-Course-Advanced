import 'package:chat/models/message_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import 'package:chat/widgets/widgets.dart';
import 'package:chat/services/chat_service.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  final List<MessageWidget> _messages = [];

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  bool _writing = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('personal-message', _listenToMessages);
    _loadHistory(this.chatService.userFor.uid);
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    for (MessageWidget message in _messages) {
      message.animationController.dispose();
    }
    _messages.clear();
    this.socketService.socket.off('personal-message');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userFor = chatService.userFor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              child: Text(userFor.name.substring(0, 2), style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(height: 3),
            Text(userFor.name, style: TextStyle(color: Colors.black87, fontSize: 12)),
          ],
        ),
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _messages[index];
                },
                reverse: true,
              ),
            ),
            Divider(height: 1),
            Container(
              child: _inputChat(),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    _writing = (text.trim().length > 0);
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Write your message here',
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: !Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Send'),
                      onPressed: _writing ? () => _handleSubmit(_textController.text.trim()) : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        color: Colors.blue[400],
                        onPressed: _writing ? () => _handleSubmit(_textController.text.trim()) : null,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.length == 0) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = MessageWidget(
      text: text,
      uid: authService.user.uid,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);

    setState(() {
      _writing = false;
    });

    this.socketService.emit('personal-message', {
      'from': this.authService.user.uid,
      'to': this.chatService.userFor.uid,
      'message': text,
    });
  }

  void _listenToMessages(dynamic payload) {
    MessageWidget message = MessageWidget(
      text: payload['message'],
      uid: payload['from'],
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 300)),
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _loadHistory(String userID) async {
    List<Message> chat = await this.chatService.getChat(userID);
    print(chat.first);
    final history = chat.map(
      (message) => MessageWidget(
        text: message.message,
        uid: message.from,
        animationController: AnimationController(vsync: this, duration: Duration.zero),
      ),
    );
    setState(() {
      _messages.insertAll(0, history);
    });
  }
}
