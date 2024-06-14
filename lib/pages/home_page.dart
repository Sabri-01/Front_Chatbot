import 'package:chatbot_project/components/input_button.dart';
import 'package:chatbot_project/components/suggest_card.dart';
import 'package:chatbot_project/pages/login_page.dart';
import 'package:chatbot_project/pages/register_page.dart';
import 'package:chatbot_project/pages/chat_page.dart';
import 'package:chatbot_project/services/auth_service.dart';
import 'package:flutter/material.dart';

/// [HomePage] est un widget de type stateflul qui permet d'afficher l'écran d'acceuil afin de communiquer avec 
/// l'IA
class HomePage extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  HomePage({super.key, required this.screenWidth, required this.screenHeight});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthService authService = AuthService();

  List<Map<String, String>> suggestions = [
    {
      'title': 'Suggestion 1',
      'description':
          "Qu'est ce que Parcoursup ?"
    },
    {
      'title': 'Suggestion 2',
      'description': "Trouve moi une école d'ingénieur publique"
    },
    {'title': 'Suggestion 3', 'description': "Parle moi de l'INSA Hauts-De-France"},
    {
      'title': 'Suggestion 4',
      'description':
          "Comment pourrais-je étudier le droit à Lyon ? "
    },
  ];

  void _signOut(BuildContext context) async {
    await authService.signOut();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Déconnexion réussie"),
          content: Text("Vous avez été déconnecté avec succès!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF36373B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF28292C),
        title: const Text('StudyMate', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: widget.screenWidth / 30.0),
            child: Image.asset(
              'assets/studymate_only_logo.png',
              height: 40,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF28292C),
              ),
              child: Text(
                'Paramètres',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Créer un compte'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Se connecter'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Se déconnecter'),
              onTap: () {
                _signOut(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
              onTap: () {
                // Ajouter la logique de paramètres ici
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const RadialGradient(
                        center: Alignment.center,
                        radius: 0.5,
                        colors: [Color(0xFFFFF6F3), Color(0xFFFFF6F3)],
                        stops: [0.5, 1.0],
                      ).createShader(bounds);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100,
                      child:
                          Image.asset('assets/studymate_logo.png', height: 135),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: widget.screenWidth / 16.0),
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
          const SizedBox(height: 10),
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
