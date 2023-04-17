import 'dart:convert';
import 'dart:io';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../types/types.dart';

void main() {
  final webSocketURL = Uri.parse('ws://localhost:8080');
  final channel = WebSocketChannel.connect(webSocketURL);
  channel.stream.listen((response) {
    final decodedOutput = json.decode(response);
    stdout.write('Result: ${decodedOutput['result']}');
  });

  Matrix firstMatrix = buildMatrix('first matrix');
  Matrix secondMatrix = buildMatrix('second matrix');

  final request = json.encode({
    'firstMatrix': firstMatrix,
    'secondMatrix': secondMatrix,
  });

  stdout.writeln('Performing request to server...');
  stdout.writeln('Payload: $request');

  channel.sink.add(request);
}

Matrix buildMatrix(String matrixName) {
  Matrix matrix = [];
  for (var i = 0; i < 2; i++) {
    MatrixRow row = [];
    for (var j = 0; j < 2; j++) {
      stdout.write('Enter the element [$i][$j] of the $matrixName: ');
      final input = stdin.readLineSync();
      final element = num.parse(input!);
      row.add(element);
    }
    matrix.add(row);
  }
  return matrix;
}
