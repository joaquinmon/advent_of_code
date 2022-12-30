import 'dart:io';
import 'dart:math';

//Para la parte 1 asiga el valor a 2022, para la parte 2 asigana el valor a 1000000000000
final int n = 1000000000000;

List<List<String>> piezas = [
  ['####'],
  ['.#.', '###', '.#.'],
  ['..#', '..#', '###'],
  ['#', '#', '#', '#'],
  ['##', '##'],
];

List<List<String>> res = [];
late List<List<Point<int>>> visto;

bool comprobarMov(int x, int y, int dx, int dy, List<String> p) {
  if (x + dx < 0 || x + p[0].length - 1 + dx >= res[0].length || y + dy < 0) {
    return false;
  }
  for (int i = 0; i < p.length; ++i) {
    for (int j = 0; j < p[i].length; ++j) {
      if (p[i][j] == '#' && res[y + p.length - i - 1 + dy][x + j + dx] == '#') {
        return false;
      }
    }
  }
  return true;
}

void comprobarRep(int i, int t, int h) {
  if (visto[i % 5][t].x != -1) {
    int periodo = i - visto[i % 5][t].x;
    if ((n - i) % periodo == 0) {
      int step = h + 1 - visto[i % 5][t].y;
      print((n - i) ~/ periodo * step + h + 1);
      exit(0);
    }
  } else {
    visto[i % 5][t] = Point(i, h + 1);
  }
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia17.txt');
  String push = file.readAsStringSync();
  visto = List.generate(5, (_) => List.filled(push.length, Point(-1, -1)));
  int h = -1, t = -1;

  for (int i = 0; i < n; ++i) {
    int x = 2, y = h + 4;
    List<String> p = piezas[i % piezas.length];
    while (res.length < y + p.length) {
      res.add('.......'.split(''));
    }

    while (true) {
      t = (t + 1) % push.length;
      comprobarRep(i, t, h);

      String d = push.substring(t, t + 1);
      int dx = (d == '<' ? -1 : 1);
      if (comprobarMov(x, y, dx, 0, p)) {
        x += dx;
      }

      if (!comprobarMov(x, y, 0, -1, p)) {
        break;
      }
      y--;
    }

    for (int i = 0; i < p.length; ++i) {
      for (int j = 0; j < p[i].length; ++j) {
        if (p[i][j] == '#') {
          res[y + p.length - i - 1][x + j] = '#';
        }
      }
    }

    h = max(h, y + p.length - 1);
  }
  print(" Dia 17: ");
  var result = h +1;
  print('   $result');
}
