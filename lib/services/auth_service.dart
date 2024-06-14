import 'package:firebase_auth/firebase_auth.dart';

/// [AuthServ] est une classe qui permet d'utiliser Firebase pour authentifier 
/// l'utilisateur 
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

/// Fonction qui permet la connexion de l'utilisateur
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

/// Fonction qui permet de s'inscrire
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

/// Deconnexion
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

/// Récupération de l'utilisateur actuel
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
