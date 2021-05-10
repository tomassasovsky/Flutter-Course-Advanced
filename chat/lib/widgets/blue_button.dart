
import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const BlueButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: Colors.blue,
        shape: StadiumBorder(),
      ),
      onPressed: this.onPressed,
    );
  }
}
