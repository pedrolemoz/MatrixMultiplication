import '../exceptions/exceptions.dart';
import '../types/types.dart';

class MatricesCalculator {
  const MatricesCalculator();

  Matrix multiply({required Matrix firstMatrix, required Matrix secondMatrix}) {
    if (_isMatrixEmpty(firstMatrix)) {
      throw EmptyMatrixException(matrix: firstMatrix);
    }

    if (_isMatrixEmpty(secondMatrix)) {
      throw EmptyMatrixException(matrix: secondMatrix);
    }

    if (_isMatrixInvalid(firstMatrix)) {
      throw InvalidMatrixException(matrix: secondMatrix);
    }

    if (_isMatrixInvalid(secondMatrix)) {
      throw InvalidMatrixException(matrix: secondMatrix);
    }

    final Matrix resultantMatrix = [
      [0, 0],
      [0, 0]
    ];

    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        for (int k = 0; k < 2; k++) {
          resultantMatrix[i][j] += firstMatrix[i][k] * secondMatrix[k][j];
        }
      }
    }

    return resultantMatrix;
  }

  bool _isMatrixEmpty(Matrix matrix) =>
      matrix.isEmpty || matrix.any((row) => row.isEmpty);

  bool _isMatrixInvalid(Matrix matrix) =>
      matrix.length != 2 || matrix.any((row) => row.length != 2);
}
