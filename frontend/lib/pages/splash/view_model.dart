import 'dart:developer';

import 'package:frontend/dart_signalR.g.dart';
import 'package:frontend/helpers/constant.dart';
import 'package:signalr_core/signalr_core.dart';

class SplashViewModel {
  Future<void> loadApp() async {
    final connection = HubConnectionBuilder()
        .withUrl(
          '$apiUrl/white-board',
          HttpConnectionOptions(
            transport: HttpTransportType.webSockets,
            logMessageContent: true,
            logging: (_, m) => log(m),
          ),
        )
        .build();

    connection.onclose((exception) {
      log('Connection closed. $exception');
    });

    await connection.start();

    signalRHub = WhiteboardHub(connection: connection);
  }
}
