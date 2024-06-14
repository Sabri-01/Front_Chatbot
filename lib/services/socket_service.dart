import 'package:socket_io_client/socket_io_client.dart' as IO;

/// [SocketService] est une classe qui utilise le package socket_io_client pour
/// permettre une communication sécurisée entre le client et le serveur.
class SocketService {
  static final SocketService _instance = SocketService._internal();
  IO.Socket? socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

/// Etablir la connection avec le serveur et vérifier si elle est correctement configurée
  void connect() {
    if (socket == null || !socket!.connected) {
      socket = IO.io('https://82.66.33.22:44444', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket!.on('connect', (_) {
        print('connected');
        socket!.emit('connection', 'Hello!');
      });

      socket!.on('disconnect', (_) {
        print('disconnected');
        socket!.emit('disconnection', 'Goodbye!');
      });

      socket!.on('ai_message', (data) {
        print('response: $data');
      });

      socket!.on('connect_error', (data) {
        print('connect_error: $data');
      });

      socket!.on('connect_timeout', (data) {
        print('connect_timeout: $data');
      });

      socket!.onError((data) {
        print('error: $data');
      });
    }
  }

/// Vérification de la connexion
  bool isConnected() {
    return socket != null && socket!.connected;
  }

/// Envoi d'un messsage à partir de l'id utilisateur uid et le contenu du message
  void sendMessage(String uid, String message) {
    final userMessage = {
      "user_id": uid,
      "message": message,
    };

    socket?.emit('user_message', userMessage);
  }

/// Récupération des messages
  void listenToMessages(Function(String) onMessage) {
    socket?.off('ai_message');
    socket?.on('ai_message', (data) {
      onMessage(data);
    });
  }

  void disconnect() {
    socket?.emit('disconnection', 'Goodbye!');
    socket?.disconnect();
  }
}
