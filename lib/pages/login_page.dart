import 'package:chatbot_project/components/register_button.dart';
import 'package:chatbot_project/components/my_textfield.dart';
import 'package:chatbot_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'register_page.dart'; // Importer la page d'inscription

/// [LoginPage] est un widget de type stateless qui permet de réaliser une connexion à son compte
/// afin d'utiliser l'IA
class LoginPage extends StatelessWidget {
  // Text editing controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthService authService = AuthService();
  LoginPage({super.key});

  // Login method
  void login(BuildContext context) async {
    final user =
        await authService.signIn(emailController.text, passwordController.text);
    if (user != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Connexion réussie"),
            content: Text("Vous êtes maintenant connecté!"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme le dialogue
                  // Naviguer vers une nouvelle page si nécessaire
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Connexion échouée')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF36373B),
      appBar: AppBar(
        backgroundColor: Color(0xFF36373B),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 25),
              MyTextfield(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController),
              const SizedBox(height: 5),
              MyTextfield(
                  hintText: "Mot de passe",
                  obscureText: true,
                  controller: passwordController),
              const SizedBox(height: 15),
              MyButton(text: "Se connecter", onTap: () => login(context)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous n'avez pas encore de compte? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: const Text(
                      " S'enregistrer ici",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
