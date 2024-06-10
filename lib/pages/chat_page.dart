import 'package:chatbot_project/components/ia_answer.dart';
import 'package:chatbot_project/components/input_button.dart';
import 'package:chatbot_project/components/user_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String initialUserMessage;

  const ChatPage(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.initialUserMessage});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ajouter le premier message de l'utilisateur à la liste des messages
    messages.add({'type': 'user', 'message': widget.initialUserMessage});
    // Simuler une réponse de l'IA
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        messages.add({
          'type': 'ia',
          'message': 'Ceci est une réponse automatique de l\'IA.'
        });
      });
    });
  }

  void _sendMessage(String message) {
    setState(() {
      messages.add({'type': 'user', 'message': message});
      // Réinitialiser le champ de saisie
      _controller.clear();
    });
    // Simuler une réponse de l'IA
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        messages.add({
          'type': 'ia',
          'message': 'Ceci est une autre réponse automatique de l\'IA.'
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF36373B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF28292C),
        title:
            const Text('UPHF ChatBot', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white, // Changer la couleur de la flèche de retour
        ),
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
          SizedBox(height: widget.screenHeight / 35.0),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                if (message['type'] == 'user') {
                  return Padding(
                      padding: EdgeInsets.only(
                          left: widget.screenWidth / 5.0,
                          right: widget.screenWidth / 15.0,
                          bottom: widget.screenHeight / 30.0),
                      child: UserMessage(
                        screenWidth: widget.screenWidth,
                        message: message['message']!,
                      ));
                } else {
                  return Padding(
                      padding: EdgeInsets.only(
                          left: widget.screenWidth / 20.0,
                          right: widget.screenWidth / 20.0,
                          bottom: widget.screenHeight / 35.0),
                      child: IAAnswer(
                        screenWidth: widget.screenWidth,
                        message: message['message']!,
                      ));
                }
              },
            ),
          ),
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
                  _sendMessage(_controller.text.trim());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
