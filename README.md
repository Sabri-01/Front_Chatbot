# Application Flutter StudyMate

## Description
StudyMate est une application de chat développée en utilisant Flutter. Elle intègre Firebase pour l'authentification des utilisateurs et Firestore pour le stockage des messages de chat. L'application permet aux utilisateurs de s'inscrire, de se connecter et de communiquer avec un chatbot IA. Les messages sont stockés dans Firestore, garantissant leur persistance entre les sessions. Ce projet a été réalisé par des étudiants de l'INSA Hauts-De-France en cybersécurité.

## Fonctionnalités
- Inscription des utilisateurs
- Connexion des utilisateurs
- Interaction avec un chatbot IA
- Stockage des messages dans Firestore

## Prérequis
Avant de commencer, assurez-vous de remplir les conditions suivantes :
- Flutter SDK installé sur votre machine de développement
- Projet Firebase configuré avec Firestore et l'authentification activée
- Connaissances de base en Dart et Flutter

## Démarrage
Suivez ces instructions pour configurer et exécuter le projet sur votre machine locale.

### Configuration du projet
1. **Cloner le dépôt**
   ```bash
   git clone <url_du_dépôt>
   cd StudyMate
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Configurer Firebase**
   - Assurez-vous que le fichier `google-services.json` est dans le répertoire `android/app`
   - Assurez-vous que le fichier `GoogleService-Info.plist` est dans le répertoire `ios/Runner`

4. **Exécuter l'application**
   ```bash
   flutter run
   ```

## Structure du répertoire
```
StudyMate/
├── android/
├── ios/
├── lib/
│   ├── components/
│   │   ├── input_button.dart
│   │   ├── ia_answer.dart
│   │   ├── my_button.dart
│   │   ├── my_textfield.dart
│   │   ├── suggest.dart
│   │   ├── user_message.dart
│   ├── pages/
│   │   ├── chat_page.dart
│   │   ├── home_page.dart
│   │   ├── login_page.dart
│   │   ├── register_page.dart
│   │   ├── splash_screen.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── firestore.dart
│   │   ├── socket_service.dart
│   ├── main.dart
├── pubspec.yaml
```

## Fichiers principaux
- **main.dart**: Point d'entrée de l'application
- **auth_service.dart**: Gère l'authentification en utilisant Firebase
- **firestore.dart**: Gère les interactions avec Firestore pour le stockage et la récupération des messages
- **socket_service.dart**: Gère les connexions WebSocket et l'envoi des messages
- **chat_page.dart**: Interface principale de chat où les utilisateurs interagissent avec l'IA

## Intégration de Firebase
### Authentification
Firebase Authentication est utilisé pour gérer les fonctionnalités d'inscription, de connexion et de déconnexion des utilisateurs.

### Firestore
Firestore est utilisé pour stocker les messages de chat et les récupérer pour les afficher.

## Documentations
- Documentation Flutter : https://docs.flutter.dev/
- Documentation Firebase : https://firebase.google.com/docs/flutter/setup?hl=fr
- Documentation Socket.IO : https://pub.dev/packages/socket_io_client

