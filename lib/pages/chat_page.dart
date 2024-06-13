import 'dart:async';
import 'package:chatbot_project/components/ia_answer.dart';
import 'package:chatbot_project/components/input_button.dart';
import 'package:chatbot_project/components/user_message.dart';
import 'package:chatbot_project/services/socket_service.dart';
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final SocketService socketService = SocketService();
  Timer? _responseTimer;

  @override
  void initState() {
    super.initState();
    // Connectez-vous au serveur WebSocket
    socketService.connect();
    // Écoutez les messages du serveur
    socketService.listenToMessages((message) {
      if (mounted) {
        setState(() {
          _addMessage({'type': 'ia', 'message': message});
        });
      }
    });

    // Ajouter le premier message de l'utilisateur à la liste des messages
    _addMessage({'type': 'user', 'message': widget.initialUserMessage});
    _sendMessageToIA(widget.initialUserMessage);
  }

  void _addMessage(Map<String, String> message) {
    messages.add(message);
    _listKey.currentState?.insertItem(messages.length - 1);
  }

  void _sendMessage(String message) {
    setState(() {
      _addMessage({'type': 'user', 'message': message});
      _controller.clear();
    });

    // Envoyer le message au serveur
    _sendMessageToIA(message);
  }

  void _sendMessageToIA(String message) {
    print('Envoi du message à l\'IA : $message');
    socketService.sendMessage(message);
  }

  @override
  void dispose() {
    // Annuler le Timer s'il existe
    _responseTimer?.cancel();
    super.dispose();
  }

  Widget _buildMessageItem(BuildContext context, int index, Animation<double> animation) {
    final message = messages[index];
    if (message['type'] == 'user') {
      return ScaleTransition(
        scale: animation,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
              left: widget.screenWidth / 5.0,
              right: widget.screenWidth / 15.0,
              bottom: widget.screenHeight / 30.0),
          child: UserMessage(
            screenWidth: widget.screenWidth,
            message: message['message']!,
          ),
        ),
      );
    } else {
      return ScaleTransition(
        scale: animation,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
              left: widget.screenWidth / 20.0,
              right: widget.screenWidth / 20.0,
              bottom: widget.screenHeight / 35.0),
          child: IAAnswer(
            screenWidth: widget.screenWidth,
            message: message['message']!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF36373B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF28292C),
        title: const Text('StudyMate', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white,
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
            child: AnimatedList(
              key: _listKey,
              initialItemCount: messages.length,
              itemBuilder: (context, index, animation) {
                return _buildMessageItem(context, index, animation);
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
