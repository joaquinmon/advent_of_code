import 'dart:io';

Map<String, int> valor = {'=': -2, '-': -1, '0': 0, '1': 1, '2': 2};

Map<int, String> letra = {-1: '-', -2: '='};

int decimal(String s) {
  int p = 1, rest = 0;
  for (int i = s.length - 1; i >= 0; --i) {
    rest += valor[s[i]]! * p;
    p *= 5;
  }
  return rest;
}

String snafu(int n) {
  String rest = "";
  while (n > 0) {
    int x = n % 5;
    if (x < 3) {
      rest += '$x';
    } else {
      rest += letra[x - 5]!;
      n += 5 - x;
    }
    n ~/= 5;
  }
  rest = rest.split('').reversed.join();
  return rest;
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia25.txt');
  int result =
      file.readAsLinesSync().map((e) => decimal(e)).reduce((a, b) => a + b);
  
  print(" Dia 25: ");
  var result2 = snafu(result);
  print('   $result2');
  print('   $result');

}
