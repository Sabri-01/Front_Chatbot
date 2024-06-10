import 'package:chatbot_project/components/input_button.dart';
import 'package:chatbot_project/components/suggest.dart';
import 'package:chatbot_project/pages/chat_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  HomePage({super.key, required this.screenWidth, required this.screenHeight});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  List<Map<String, String>> suggestions = [
    {'title': 'Suggestion 1', 'description': 'Description 1 qui est très longue pour tester le retour à la ligne automatique.'},
    {'title': 'Suggestion 2', 'description': 'Description 2 qui est également longue.'},
    {'title': 'Suggestion 3', 'description': 'Description 3 courte.'},
    {'title': 'Suggestion 4', 'description': 'Description 4 qui est encore plus longue pour bien tester le retour à la ligne.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF36373B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF28292C),
        title: const Text('UPHF ChatBot', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: widget.screenWidth / 30.0),
            child: Image.asset(
              'assets/logo_uphf.png',
              height: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Image.asset('assets/logo_uphf.png'),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // Suggestions en ListView horizontale
          SizedBox(
            height: 100, // Hauteur définie pour la ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SuggestionButton(
                    title: suggestions[index]['title']!,
                    description: suggestions[index]['description']!,
                    onTap: () {
                      setState(() {
                        _controller.text = suggestions[index]['description']!;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10), // Espace entre les suggestions et le bouton d'entrée
          Padding(
            padding: EdgeInsets.only(
              left: widget.screenWidth / 16.0,
              right: widget.screenWidth / 16.0,
              bottom: widget.screenHeight / 25.0,
            ),
            child: InputButton(
              width: widget.screenWidth,
              height: widget.screenHeight,
              controller: _controller,
              onPress: () {
                if (_controller.text.trim().isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        screenWidth: widget.screenWidth,
                        screenHeight: widget.screenHeight,
                        initialUserMessage: _controller.text.trim(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
