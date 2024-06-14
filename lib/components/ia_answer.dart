import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour utiliser Clipboard

/// [IAAnswer] est un widget de type stateless qui prend en paramètre un champ de texte messsage et la taille de l'écran
/// afin d'afficher les messages de l'IA 
class IAAnswer extends StatelessWidget {
  final String message;
  final double screenWidth;

  const IAAnswer({super.key, required this.message, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Copier le message dans le presse-papiers lors du clic
        Clipboard.setData(ClipboardData(text: message));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Message copié dans le presse-papiers')));
      },
      child: SizedBox(
        width: screenWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo de l'IA
            Image.asset('assets/studymate_only_logo.png', height: 50),
            const SizedBox(width: 20),
            // Texte de réponse de l'IA
            Expanded(
                child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
              softWrap: true,
              child: Text(message),
            )),
          ],
        ),
      ),
    );
  }
}
