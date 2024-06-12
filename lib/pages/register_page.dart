import 'package:chatbot_project/components/my_button.dart';
import 'package:chatbot_project/components/my_textfield.dart';
import 'package:chatbot_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Importer la page de connexion

class RegisterPage extends StatelessWidget {
  // Text editing controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPWController = TextEditingController();

  AuthService authService = AuthService();
  RegisterPage({super.key});

  // Register method
  void register(BuildContext context) async {
    if (passwordController.text == confirmPWController.text) {
      final user = await authService.signUp(emailController.text, passwordController.text);
      if (user != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Inscription réussie"),
              content: Text("Vous avez été enregistré avec succès!"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Ferme le dialogue
                    Navigator.pop(context); // Retourne à l'écran précédent
                  },
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inscription échouée')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Les mots de passe ne correspondent pas')));
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
              Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 25),
              MyTextfield(
                  hintText: "Nom d'utilisateur",
                  obscureText: false,
                  controller: usernameController),
              const SizedBox(height: 5),
              MyTextfield(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController),
              const SizedBox(height: 5),
              MyTextfield(
                  hintText: "Mot de passe",
                  obscureText: true,
                  controller: passwordController),
              const SizedBox(height: 5),
              MyTextfield(
                  hintText: "Confirmer mot de passe",
                  obscureText: true,
                  controller: confirmPWController),
              const SizedBox(height: 15),
              MyButton(text: "S'enregistrer", onTap: () => register(context)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Vous avez déjà un compte? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      " Se connecter ici",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
