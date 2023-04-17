import '../types/types.dart';

class EmptyMatrixException implements Exception {
  final Matrix matrix;

  const EmptyMatrixException({required this.matrix});
}

class InvalidMatrixException implements Exception {
  final Matrix matrix;

  const InvalidMatrixException({required this.matrix});
}
