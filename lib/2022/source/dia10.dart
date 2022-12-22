import 'dart:io';

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia10.txt');

  for (String linea in file.readAsLinesSync()) {
    if (linea == 'noop') {
      tick();
    } else {
      tick();
      tick();
      x += int.parse(linea.split(' ')[1]);
    }
  }
  print(' Dia 10: ');
  print('   $suma');
  for (List<String> line in res) {
    var crt = line.join();
    print('   $crt');
  }
}

int suma = 0, t = 0, x = 1;
List<List<String>> res = List.generate(6, (_) => List.filled(40, '.'));

void tick() {
  if (t % 40 >= x - 1 && t % 40 <= x + 1) {
    res[t ~/ 40][t % 40] = '#';
  }
  t++;
  if (t % 40 == 20) {
    suma += t * x;
  }
}
