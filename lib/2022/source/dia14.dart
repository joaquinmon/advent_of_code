import 'dart:io';
import 'dart:math';

//Para ver el resultado de la parte 1 tiene que esta asignado en true, para la parte 2 en false
final bool parte1 = false;
final int inf = 1000;
final List<int> dx = [0, -1, 1];

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia14.txt');
  List<List<String>> mapa = List.generate(inf, (_) => List.filled(inf, '.'));
  int maxy = -1;
  for (String linea in file.readAsLinesSync()) {
    int prevx = -1, prevy = -1;
    for (String token in linea.split('->')) {
      List<String> cord = token.trim().split(',');
      int x = int.parse(cord[0]);
      int y = int.parse(cord[1]);
      draw(prevx, prevy, x, y, mapa);
      prevx = x;
      prevy = y;
      maxy = max(maxy, y);
    }
  }

  if (!parte1) {
    for (int x = 0; x < inf; ++x) {
      mapa[maxy + 2][x] = '#';
    }
    maxy += 2;
  }

  int result = 0;
  while (true) {
    int x = 500, y = 0;
    while (true) {
      bool rest = true;
      for (int i = 0; i < 3; ++i) {
        if (mapa[y + 1][x + dx[i]] == '.') {
          y++;
          x += dx[i];
          rest = false;
          break;
        }
      }
      if (rest || y > maxy) {
        break;
      }
    }
    if (y > maxy) {
      break;
    }
    mapa[y][x] = 'o';
    result++;
    if (!parte1 && x == 500 && y == 0) {
      break;
    }
  }
  print(" Dia 14: ");
  print('   $result');
}

void draw(int x0, int y0, int x1, int y1, List<List<String>> mapa) {
  if (x0 == -1) {
    mapa[y1][x1] = '#';
    return;
  }
  if (x0 == x1) {
    if (y0 > y1) {
      int temp = y0;
      y0 = y1;
      y1 = temp;
    }
    for (int y = y0; y <= y1; ++y) {
      mapa[y][x0] = '#';
    }
    return;
  }
  if (x0 > x1) {
    int tmp = x0;
    x0 = x1;
    x1 = tmp;
  }
  for (int x = x0; x <= x1; ++x) {
    mapa[y0][x] = '#';
  }
}
