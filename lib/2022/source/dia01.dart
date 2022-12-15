import 'dart:io';



void main() {
  File file = File('../lib/2022/data/dia01.txt');
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
  print(arr.last);
  print(arr[arr.length - 1] + arr[arr.length - 2] + arr[arr.length - 3]);
}
