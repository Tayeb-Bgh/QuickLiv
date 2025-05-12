// lib/core/socket_service.dart
import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  static final SocketService _instance = SocketService._internal();
  final String _serverUrl = 'https://quickbi3backend-u8l71xbz.b4a.run:3000';

  factory SocketService() => _instance;

  SocketService._internal() {
    socket = IO.io(_serverUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 1000,
    });

    socket.onConnect((_) => log('Connecté au serveur WS'));
    socket.onDisconnect((_) => log('Déconnecté du serveur WS'));
    socket.onError((err) => log('Erreur WS: $err'));
  }

  void connect() => socket.connect();
  void disconnect() => socket.disconnect();

  void joinDelivererRoom() {
    socket.emit('join_deliverer_room', 7);
  }

  void listenForNewOrders(void Function() callback) {
    socket.on('new_orders_available', (_) => callback());
  }

  void listenForRemovedOrders(void Function(List<dynamic>) callback) {
    socket.on('orders_removed', (data) => callback(data));
  }
}
