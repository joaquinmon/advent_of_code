import 'dart:io';

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia04.txt');
  int result = 0, result2 = 0;
  for (String linea in file.readAsLinesSync()) {
    List<String> tokens = linea.split(RegExp('[-,]'));
    assert(tokens.length == 4);
    List<int> array = [];
    for (String t in tokens) {
      array.add(int.parse(t));
    }
    if ((array[0] <= array[2] && array[1] >= array[3]) ||
        (array[2] <= array[0] && array[3] >= array[1])) {
      result++;
    }
    if ((array[0] > array[3]) || (array[1] < array[2])) {
      continue;
    }
    result2++;
  }
  print(" Dia 4: ");
  print('   $result');
  print('   $result2');
}
