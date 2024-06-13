import 'package:chatbot_project/components/ia_answer.dart';
import 'package:chatbot_project/components/input_button.dart';
import 'package:chatbot_project/components/user_message.dart';
import 'package:chatbot_project/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatbot_project/services/socket_service.dart'; // Importez votre service Socket
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final SocketService socketService = SocketService();
  final FirestoreService firestoreService = FirestoreService();
  void fetchMessages() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('messages').get();

    // Convertir les documents en une liste de Map
    List<Map<String, dynamic>> allMessages = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // Filtrer les messages pour l'utilisateur spécifique en local
    List<Map<String, dynamic>> filteredMessages = allMessages
        .where((message) => message['user'] == 'jupQXBfzgcc5IJDEQOg8wV3xhml1')
        .toList();

    // Trier les messages en fonction du timestamp décroissant
    filteredMessages.sort((a, b) {
      Timestamp timestampA = a['timestamp'];
      Timestamp timestampB = b['timestamp'];
      return timestampB.compareTo(timestampA); // Descending order
    });

    // Extraire et convertir en Map<String, String>
    List<Map<String, String>> resultMessages = filteredMessages
        .map((message) => {
              'type': message['message']['type'].toString(),
              'message': message['message']['message'].toString()
            })
        .toList();

    for (var messagee in resultMessages) {
      print(messagee);
        // Accès avec vérification nulle
        String? nullableMessage = messagee['message'];
        if (nullableMessage != null) {
          String message = nullableMessage;
          _sendMessageSansIA(message);
          print('Message: $message'); // Output: ggg
        } else {
          print('Message not found');
        }
      
    }
    //this.messages = resultMessages;
  }

  @override
  void initState() {
    super.initState();
    // Connectez-vous au serveur WebSocket
    socketService.connect();
    // Écoutez les messages du serveur
    socketService.listenToMessages((message) {
      setState(() {
        _addMessage({'type': 'ia', 'message': message});
      });
    });
    fetchMessages();

    _addMessage({'type': 'user', 'message': widget.initialUserMessage});
    _sendMessageToIA(widget.initialUserMessage);
  }

  void _addMessage(Map<String, String> message) {
    messages.add(message);

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Obtenir l'UID de l'utilisateur connecté
      String uid = user.uid;
      firestoreService.addMessage(user.uid, message);
      print("UID de l'utilisateur connecté : $uid");
    } else {
      print("Aucun utilisateur connecté.");
    }

    _listKey.currentState?.insertItem(messages.length - 1);
  }
void _sendMessageSansIA(String message) {
    setState(() {
      _addMessage({'type': 'user', 'message': message});
      _controller.clear();
    });



    // Envoyer le message au serveur (optionnel pour le test)
    // _sendMessageToIA(message);
  }

  void _sendMessage(String message) {
    setState(() {
      _addMessage({'type': 'user', 'message': message});
      _controller.clear();
    });

    // Ajouter une réponse automatique de l'IA pour le test
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _addMessage({
          'type': 'ia',
          'message': 'Ceci est une réponse automatique de l\'IA.'
        });
      });
    });

    // Envoyer le message au serveur (optionnel pour le test)
    // _sendMessageToIA(message);
  }

  void _sendMessageToIA(String message) {
    socketService.sendMessage(message);
  }

  @override
  void dispose() {
    // Déconnectez-vous du serveur WebSocket
    socketService.disconnect();
    super.dispose();
  }

  Widget _buildMessageItem(
      BuildContext context, int index, Animation<double> animation) {
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
