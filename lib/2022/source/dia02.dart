import 'dart:io';

void main() {

 File file = File('../lib/2022/data/dia02.txt');
  int result = 0, result2 = 0;

  for (String line in file.readAsLinesSync()) {
    int x = line.codeUnitAt(0) - 'A'.codeUnitAt(0);
    int y = line.codeUnitAt(2) - 'X'.codeUnitAt(0);
    result += y + 1;

    if (x == y) {
      result += 3;
    } else if ((x + 1) % 3 == y) {
      result += 6;
    }

    if (y == 0) {
      result2 += (x + 2) % 3 + 1;
    } else if (y == 1) {
      result2 += x + 4;
    } else {
      result2 += (x + 1) % 3 + 7;
    }

  }

  print(" Dia 2: ");
  print('   $result');
  print('   $result2');
  
}
