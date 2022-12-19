import 'dart:io';



void main() {
  File file = File('../advent_of_code/lib/2022/data/dia01.txt');
  List<int> arr = [];
  int cur = 0;

  for (String line in file.readAsLinesSync()) {
    if (line == '') {
      arr.add(cur);
      cur = 0;
    } else {
      cur += int.parse(line);
    }
  }
  
  arr.sort();
  print(' Dia 1: ');

  var result = arr.last;
  print('   $result');

  var result2 = arr[arr.length - 1] + arr[arr.length - 2] + arr[arr.length - 3];
  print('   $result2');
  
}
