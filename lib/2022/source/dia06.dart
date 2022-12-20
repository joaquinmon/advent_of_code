import 'dart:io';

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia07.txt');
  String s = file.readAsStringSync();
  
  int markerLen = 4;
  int markerLen2 = 14;

  print(" Dia 6: ");
  for (int i = 0; i + markerLen - 1 < s.length; ++i) {
    if (s.substring(i, i + markerLen).split('').toSet().length == markerLen) {
      var result = i + markerLen;
      print('   $result');
      break;
    }
  }

  for (int i = 0; i + markerLen2 - 1 < s.length; ++i) {
    if (s.substring(i, i + markerLen2).split('').toSet().length == markerLen2) {
      var result2 = i + markerLen2;
      print('   $result2');
      break;
    }
  }
}