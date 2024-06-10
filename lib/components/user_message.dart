import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour utiliser Clipboard

class UserMessage extends StatelessWidget {
  final String message;
  final double screenWidth;

  const UserMessage({super.key, required this.message, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Copier le message dans le presse-papiers lors du clic
        Clipboard.setData(ClipboardData(text: message));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message copié dans le presse-papiers'))
        );
      },
      child: Container(
        width: screenWidth,
        padding:  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: const Color(0xFF45464B),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 18.0  ),
          softWrap: true, // Pour permettre au texte de revenir à la ligne
        ),
      ),
    );
  }
}
