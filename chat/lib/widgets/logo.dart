import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 170,
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Image.asset('assets/tag-logo.png'),
            SizedBox(height: 20),
            Text(this.title, style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
