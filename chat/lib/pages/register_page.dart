import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/widgets/widgets.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/helpers/show_alert.dart';
import 'package:chat/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * .95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(
                    title: 'Register',
                  ),
                  _Form(),
                  Labels(
                    route: 'login',
                    title: 'Already have an account?',
                    subtitle: 'Login!',
                  ),
                  Container(
                    child: Text('Terms and Conditions of Use', style: TextStyle(fontWeight: FontWeight.w200)),
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    register() async {
      FocusScope.of(context).unfocus();
      final registerOK = await authService.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (registerOK.runtimeType == bool && registerOK) {
        socketService.connect();
        Navigator.pushReplacementNamed(context, 'users');
      } else {
        showAlert(context, 'Registering failed.', registerOK);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Name & Surname',
            keyboardType: TextInputType.text,
            controller: nameController,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            isPassword: true,
          ),
          BlueButton(
            text: 'Register',
            onPressed: authService.authenticating ? null : register,
          ),
        ],
      ),
    );
  }
}
