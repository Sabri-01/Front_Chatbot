import 'package:flutter/material.dart';

/// [InputButton] est un widget de type stateless qui permet d'afficher une barre de recherche qui s'adapte à la 
/// taille de l'écran et qui prend en paramètre une image et une fonction qui permettent de définir une action lors 
/// de l'appui
class InputButton extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final double imageHeight;
  final FontWeight fontWeight;
  final void Function() onPress;
  final Image image;
  final TextEditingController controller;

  InputButton(
      {super.key,
      required this.width,
      required this.height,
      required this.onPress,
      required this.controller,
      this.fontSize = 20.0,
      this.fontWeight = FontWeight.w400,
      this.imageHeight = 40.0,
      Image? image})
      : image = image ?? Image.asset('assets/send_icon.png', height: imageHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        style: TextStyle(
            color: Colors.white, fontWeight: fontWeight, fontSize: fontSize),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF45464B),
          hintText: 'Message...',
          hintStyle: TextStyle(
              color: Colors.white, fontWeight: fontWeight, fontSize: fontSize),
          prefixIcon: IconButton(
            icon: Image.asset(
              'assets/broom.png',
              height: imageHeight,
              color: const Color(0xFF340038),
            ),
            onPressed: () {
              controller.clear();
            },
          ),
          suffixIcon: IconButton(icon: image, onPressed: onPress),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
