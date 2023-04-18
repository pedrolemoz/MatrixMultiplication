import '../types/types.dart';

class EmptyMatrixException implements Exception {
  final Matrix matrix;

  const EmptyMatrixException({required this.matrix});

  @override
  String toString() => 'The matrix $matrix is empty';
}

class InvalidMatrixException implements Exception {
  final Matrix matrix;

  const InvalidMatrixException({required this.matrix});

  @override
  String toString() => 'The matrix $matrix has an invalid size';
}
