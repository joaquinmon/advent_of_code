import 'dart:io';
import 'dart:math';

int m = 0, n = 0;
late List<List<int>> h;

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia08.txt');
  List<String> a = file.readAsLinesSync();
  m = a.length;
  n = a[0].length;
  h = List.generate(m, (i) => List.generate(n, (j) => a[i].codeUnitAt(j) - 48));

  List<List<int>> correcto = List.generate(m, (_) => List.filled(n, 0));
  List<List<int>> puntos = List.generate(m, (_) => List.filled(n, 1));

  List<int> list = List.empty(growable: true);
  for (int i = 0; i < m; ++i) {
    list.clear();
    for (int j = 0; j < n; ++j) {
      while (list.length > 0 && h[i][j] > h[i][list.last]) {
        list.removeLast();
      }
      if (list.length > 0) {
        puntos[i][j] *= j - list.last;
      } else {
        correcto[i][j] = 1;
        puntos[i][j] *= j;
      }
      list.add(j);
    }
    list.clear();
    for (int j = n - 1; j >= 0; --j) {
      while (list.length > 0 && h[i][j] > h[i][list.last]) {
        list.removeLast();
      }
      if (list.length > 0) {
        puntos[i][j] *= list.last - j;
      } else {
        correcto[i][j] = 1;
        puntos[i][j] *= n - 1 - j;
      }
      list.add(j);
    }
  }

  for (int j = 0; j < n; ++j) {
    list.clear();
    for (int i = 0; i < m; ++i) {
      while (list.length > 0 && h[i][j] > h[list.last][j]) {
        list.removeLast();
      }
      if (list.length > 0) {
        puntos[i][j] *= i - list.last;
      } else {
        correcto[i][j] = 1;
        puntos[i][j] *= i;
      }
      list.add(i);
    }
    list.clear();
    for (int i = m - 1; i >= 0; --i) {
      while (list.length > 0 && h[i][j] > h[list.last][j]) {
        list.removeLast();
      }
      if (list.length > 0) {
        puntos[i][j] *= list.last - i;
      } else {
        correcto[i][j] = 1;
        puntos[i][j] *= m - 1 - i;
      }
      list.add(i);
    }
  }

  var result = correcto.fold<int>(0, (res, row) => res + row.reduce((a, b) => a + b));
  var result2 = puntos.fold<int>(0, (res, row) => max(res, row.reduce(max)));
  print(" Dia 8: ");
  print('   $result');
  print('   $result2');
}
