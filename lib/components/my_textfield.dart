import 'package:flutter/material.dart';

/// [MyTextField] est un widget de type stateless qui permet d'entrer un champ de texte
class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        ), 
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white10)
      ),
      obscureText: obscureText,
    );
  }
}
