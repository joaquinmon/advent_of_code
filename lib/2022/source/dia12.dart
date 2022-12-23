import 'dart:collection';
import 'dart:io';
import 'dart:math';

//Para ver el resultado de la parte 1 tiene que esta asignado en false, para la parte 2 en true
final bool parte2 = true;
final int inf = 1000000000;
final List<Point<int>> dir = [
  Point(-1, 0),
  Point(0, 1),
  Point(1, 0),
  Point(0, -1)
];

int altura(Point<int> a, List<String> mapa) {
  if (mapa[a.x][a.y] == 'S') {
    return 0;
  } else if (mapa[a.x][a.y] == 'E') {
    return 25;
  } else {
    return mapa[a.x].codeUnitAt(a.y) - 97;
  }
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia12.txt');
  List<String> mapa = file.readAsLinesSync();
  int m = mapa.length, n = mapa[0].length;

  List<List<int>> dist = List.generate(m, (index) => List.filled(n, inf));
  Queue<Point<int>> q = Queue();
  int ex = -1, ey = -1;
  for (int i = 0; i < m; ++i) {
    for (int j = 0; j < n; ++j) {
      if (mapa[i][j] == 'S' || (parte2 && mapa[i][j] == 'a')) {
        dist[i][j] = 0;
        q.addLast(Point<int>(i, j));
      } else if (mapa[i][j] == 'E') {
        ex = i;
        ey = j;
      }
    }
  }

  while (q.isNotEmpty) {
    Point<int> a = q.removeFirst();
    for (var d in dir) {
      Point<int> b = Point(a.x + d.x, a.y + d.y);
      if (b.x >= 0 &&
          b.x < m &&
          b.y >= 0 &&
          b.y < n &&
          altura(a, mapa) + 1 >= altura(b, mapa) &&
          dist[b.x][b.y] > dist[a.x][a.y] + 1) {
        dist[b.x][b.y] = dist[a.x][a.y] + 1;
        q.addLast(b);
      }
    }
  }
  var result = dist[ex][ey];
  print(" Dia 12: ");
  print('   $result');
}
