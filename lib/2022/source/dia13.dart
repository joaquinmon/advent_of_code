import 'dart:io';
import 'dart:math';
import 'dart:convert';

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia13.txt');
  List<String> lineas = file.readAsLinesSync();
  List<dynamic> paquetes = [];
  int result = 0;
  for (int i = 0; i + 1 < lineas.length; i += 3) {
    dynamic a = json.decode(lineas[i]);
    dynamic b = json.decode(lineas[i + 1]);
    paquetes.add(a);
    paquetes.add(b);
    if (comparar(a, b) < 0) {
      result += i ~/ 3 + 1;
    }
  }
  print(" Dia 13: ");
  print('   $result');

  paquetes.add([
    [2]
  ]);
  paquetes.add([
    [6]
  ]);
  paquetes.sort(comparar);

  for (int i = 0; i < paquetes.length; ++i) {
    if (jsonEncode(paquetes[i]) == '[[2]]' ||
        jsonEncode(paquetes[i]) == '[[6]]') {
      // Multiplica los dos resultados
      var result2 = i + 1;
      print('   $result2');
    }
  }
}

int comparar(dynamic a, dynamic b) {
  if (a is int) {
    if (b is int) {
      return a.compareTo(b);
    }
    return comparar([a], b);
  }
  if (b is int) {
    return comparar(a, [b]);
  }
  if (a is List && b is List) {
    int n = min(a.length, b.length);
    for (int i = 0; i < n; ++i) {
      int temp = comparar(a[i], b[i]);
      if (temp != 0) {
        return temp;
      }
    }
    return a.length.compareTo(b.length);
  }
  throw Exception('Fallo!');
}
