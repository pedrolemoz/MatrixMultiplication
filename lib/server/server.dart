import 'dart:convert';
import 'dart:isolate';

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

import '../calculator/matrices_calculator.dart';
import '../types/types.dart';

void main() {
  final calculator = MatricesCalculator();

  final handler = webSocketHandler(
    (webSocket) {
      webSocket.stream.listen(
        (message) async {
          final receivePort = ReceivePort();
          final input = json.decode(message);
          final firstMatrix = input['firstMatrix'];
          final secondMatrix = input['secondMatrix'];
          final isolate = await Isolate.spawn(
            performMultiplication,
            [
              calculator,
              firstMatrix,
              secondMatrix,
              receivePort.sendPort,
            ],
          );
          Matrix result = await receivePort.first;
          webSocket.sink.add(json.encode({'result': result}));
          receivePort.close();
          isolate.kill();
        },
      );
    },
  );

  shelf_io.serve(handler, 'localhost', 8080).then((server) =>
      print('Serving at ws://${server.address.host}:${server.port}'));
}

void performMultiplication(List<dynamic> arguments) {
  MatricesCalculator calculator = arguments.first;
  final firstMatrix = arguments[1];
  final secondMatrix = arguments[2];
  SendPort sendPort = arguments.last;
  final result = calculator.multiply(
    firstMatrix: [
      [firstMatrix[0][0], firstMatrix[0][1]],
      [firstMatrix[1][0], firstMatrix[1][1]],
    ],
    secondMatrix: [
      [secondMatrix[0][0], secondMatrix[0][1]],
      [secondMatrix[1][0], secondMatrix[1][1]],
    ],
  );
  sendPort.send(result);
}
