import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.hintext,
      required this.obscure,
      required this.controller});
  final String hintext;
  final bool obscure;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintext,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
