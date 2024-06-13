import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  IO.Socket? socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  void connect() {
    if (socket == null || !socket!.connected) {
      socket = IO.io('https://82.66.33.22:44444', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      
        socket!.emit('connection', 'Hello!');
    

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

      // socket!.on('error', (data) {
      //   print('error: $data');
      // });

      socket!.onError((data) {
        print('error: $data');
      });
    }
  }

  bool isConnected() {
    return socket != null && socket!.connected;
  }

  void sendMessage(String message) {
    socket?.emit('user_message', message);
  }

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
