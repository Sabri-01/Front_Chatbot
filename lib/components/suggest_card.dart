import 'package:flutter/material.dart';

/// [SuggestionButton] est un wiget de type Stateless qui permet d'afficher une carte avec un titre
/// et une description donné en parmamètre. On donne aussi la possibilité d'effectuer une action lors de 
/// l'appui 
class SuggestionButton extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const SuggestionButton(
      {super.key, required this.title, required this.description, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: screenWidth * 0.8, // Limite la largeur à 80% de la largeur de l'écran
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF45464B),
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
