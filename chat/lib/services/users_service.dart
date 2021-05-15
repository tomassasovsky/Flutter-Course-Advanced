import 'package:chat/global/enviroment.dart';
import 'package:chat/models/users_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/user.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('${Enviroment.apiUrl}/users'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        },
      );
      final usersResponse = usersResponseFromJson(response.body);
      return usersResponse.users;
    } catch (error) {
      return [];
    }
  }
}
