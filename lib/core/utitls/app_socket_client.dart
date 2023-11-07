import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppSocketClient {
  late IO.Socket socket;

  /// onSocketConnected: Callback when the socket connection is successfully established
  /// You can perform actions when the connection is established, like joining a chat room.
  ///
  ///onSocketDisconnected: Callback when the socket is disconnected
  ///You can handle reconnection attempts or display an error message.
  IO.Socket init({
    required Function(IO.Socket) onSocketConnected,
    required Function(IO.Socket) onSocketDisconnected,
  }) {
    socket = IO.io(
        'http://10.0.2.2:3000/',
        IO.OptionBuilder()
            .setTransports(<String>['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());

    socket.connect();
    socket.onConnect((dynamic data) {
      debugPrint('Socket connected');
      print(data);
    });
    socket.onConnectError((dynamic data) {
      debugPrint('Socket Connection Error: $data');
    });

    socket.onDisconnect((dynamic data) {
      debugPrint('Socket.IO Disconnected: $data');
    });

    return socket;
  }


  IO.Socket disconnect(){
    return socket.disconnect();
  }
}
