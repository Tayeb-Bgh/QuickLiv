// lib/core/socket_service.dart
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  static final SocketService _instance = SocketService._internal();
  final String _serverUrl = 'http://192.168.54.7:3000';
  factory SocketService() => _instance;

  SocketService._internal() {
    socket = IO.io(_serverUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 1000,
    });

    socket.onConnect((_) => print('Connecté au serveur WS'));
    socket.onDisconnect((_) => print('Déconnecté du serveur WS'));
    socket.onError((err) => print('Erreur WS: $err'));
  }

  void connect() => socket.connect();
  void disconnect() => socket.disconnect();

  void joinOrderRoom(String orderId) {
    socket.emit('join_commande_room', orderId);
  }

  void listenForOrderUpdates(void Function(dynamic) callback) {
    socket.on('commande_status_update', callback);
  }
}
