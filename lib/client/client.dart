import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../types/types.dart';

void main() {
  final webSocketURL = Uri.parse('ws://localhost:8080');
  final channel = WebSocketChannel.connect(webSocketURL);

  channel.stream.listen((response) {
    final decodedOutput = json.decode(response);

    if (decodedOutput['result'] == null) {
      final errorType = decodedOutput['error'];
      final reason = decodedOutput['reason'];
      stdout.writeln('$errorType: $reason');
    } else {
      final result = decodedOutput['result'];
      final payload = decodedOutput['payload'];
      stdout.writeln('Result: $result\nPayload: $payload\n');
    }
  });

  final payloads = generateAllPayloads(quantity: 1000);

  for (var payload in payloads) {
    sendPayloadToWebSocket(channel, payload);
  }
}

Matrix generateMatrix(Random random) {
  Matrix matrix = [];

  for (var i = 0; i < 2; i++) {
    MatrixRow row = [];
    for (var j = 0; j < 2; j++) {
      row.add(random.nextInt(99));
    }
    matrix.add(row);
  }

  return matrix;
}

String generatePayload() {
  final random = Random();

  Matrix firstMatrix = generateMatrix(random);
  Matrix secondMatrix = generateMatrix(random);

  final request = json.encode({
    'firstMatrix': firstMatrix,
    'secondMatrix': secondMatrix,
  });

  return request;
}

List<String> generateAllPayloads({int quantity = 10}) {
  final payloads = <String>[];

  for (var i = 0; i < quantity; i++) {
    final payload = generatePayload();
    payloads.add(payload);
  }

  return payloads;
}

void sendPayloadToWebSocket(WebSocketChannel channel, String payload) {
  // stdout.writeln('Performing request to server...');
  // stdout.writeln('Payload: $payload');
  channel.sink.add(payload);
}
