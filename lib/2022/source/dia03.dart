import 'dart:io';


void main() {
  File file = File('../lib/2022/data/dia03.txt');
  int result = 0, result2 = 0;
  int lineaNum = 0;
  List cntLineas = [0, 0, 0];

  for (String linea in file.readAsLinesSync()) {
    lineaNum++;
    int cnt = 0;
    for (int i = 0; i < linea.length / 2; ++i) {
      cnt |= 1 << id(linea.codeUnitAt(i));
    }
    for (int i = linea.length ~/ 2; i < linea.length; ++i) {
      if (bit(cnt, id(linea.codeUnitAt(i)))) {
        result += id(linea.codeUnitAt(i)) + 1;
        break;
      }
    }

    
    for (int x in linea.codeUnits) {
      cntLineas[lineaNum % 3] |= 1 << id(x);
    }
    if (lineaNum % 3 == 0) {
      int cruze = cntLineas[0] & cntLineas[1] & cntLineas[2];
      for (int i = 0; i < 52; ++i) {
        if (bit(cruze, i)) {
          result2 += i + 1;
          break;
        }
      }
      cntLineas = [0, 0, 0];
    }
  }
  print(" Dia 3: ");
  print('   $result');
  print('   $result2');
}

int id(int x) {
  if (x >= 97) {
    return x - 97;
  }
  return x - 39;
}

bool bit(int n, int i) {
  return ((n >> i) & 1) > 0;
}
