import 'package:test/test.dart';

import 'package:matrix_multiplication/calculator/matrices_calculator.dart';
import 'package:matrix_multiplication/exceptions/exceptions.dart';
import 'package:matrix_multiplication/types/types.dart';

void main() {
  const calculator = MatricesCalculator();
  const Matrix tFirstMatrix = [
    [2, 3],
    [-1, 0]
  ];
  const Matrix tSecondMatrix = [
    [1, -2],
    [0, 5],
  ];
  const Matrix tResultantMatrix = [
    [2, 11],
    [-1, 2]
  ];

  test("Should multiply two matrices correctly", () {
    final result = calculator.multiply(
      firstMatrix: tFirstMatrix,
      secondMatrix: tSecondMatrix,
    );

    expect(
      result,
      isA<Matrix>().having(
        (matrix) => matrix,
        'Has the correct result',
        tResultantMatrix,
      ),
    );
  });

  group('Empty Matrices', () {
    test("Should throw EmptyMatrixException when the first matrix is empty",
        () {
      expect(
        () => calculator.multiply(
          firstMatrix: const [],
          secondMatrix: tSecondMatrix,
        ),
        throwsA(isA<EmptyMatrixException>()),
      );
    });

    test(
        "Should throw EmptyMatrixException when the first matrix has an empty row or column",
        () {
      expect(
        () => calculator.multiply(
          firstMatrix: const [
            [0, 1],
            []
          ],
          secondMatrix: tSecondMatrix,
        ),
        throwsA(isA<EmptyMatrixException>()),
      );
    });

    test("Should throw EmptyMatrixException when the second matrix is empty",
        () {
      expect(
        () => calculator.multiply(
          firstMatrix: tFirstMatrix,
          secondMatrix: const [],
        ),
        throwsA(isA<EmptyMatrixException>()),
      );
    });

    test(
        "Should throw EmptyMatrixException when the first matrix has an empty row or column",
        () {
      expect(
        () => calculator.multiply(
          firstMatrix: tFirstMatrix,
          secondMatrix: const [
            [0, 1],
            []
          ],
        ),
        throwsA(isA<EmptyMatrixException>()),
      );
    });
  });

  group('Invalid Matrices', () {
    test("Should throw InvalidMatrixException when the first matrix is not 2x2",
        () {
      expect(
        () => calculator.multiply(
          firstMatrix: [
            [1],
            [2, 3]
          ],
          secondMatrix: tSecondMatrix,
        ),
        throwsA(isA<InvalidMatrixException>()),
      );
    });

    test(
        "Should throw InvalidMatrixException when the second matrix is not 2x2",
        () {
      expect(
        () => calculator.multiply(
          firstMatrix: tFirstMatrix,
          secondMatrix: [
            [1],
            [2, 3]
          ],
        ),
        throwsA(isA<InvalidMatrixException>()),
      );
    });
  });
}
