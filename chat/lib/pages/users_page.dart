import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

import 'package:chat/models/user.dart';
import 'package:chat/services/users_service.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController = RefreshController();

  final usersService = UsersService();
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    this._loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.user;

    final online = (socketService.serverStatus == ServerStatus.online);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Messages - ${user.name}',
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              online ? Icons.check_circle : Icons.error,
              color: online ? Colors.blue[100] : Colors.red,
            ),
          )
        ],
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onLoading: () {},
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsers(),
      ),
    );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return _userListTile(users[index]);
      },
      itemCount: users.length,
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userFor = user;
        Navigator.pushNamed(context, 'chat');
      },
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[300] : Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void _loadUsers() async {
    this.users = await usersService.getUsers();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
