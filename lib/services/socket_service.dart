import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://<YOUR_SERVER_IP>:3000', IO.OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect()  // disable auto-connection
      .build()
    );

    socket.connect();
    
    socket.onConnect((_) {
      print('Connected to socket server');
    });

    socket.onConnectError((data) {
      print('Connection Error: $data');
    });

    socket.onConnectTimeout((data) {
      print('Connection Timeout: $data');
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket server');
    });

    socket.on('fromServer', (data) {
      print('Response from server: $data');
    });
  }

  void sendMessage(String message) {
    socket.emit('message', message);
  }

  void listenToMessages(Function(String) onMessage) {
    socket.on('message', (data) {
      onMessage(data);
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
