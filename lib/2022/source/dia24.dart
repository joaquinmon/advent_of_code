import 'dart:collection';
import 'dart:io';
import 'dart:math';

final List<int> dx = [-1, 0, 1, 0, 0];
final List<int> dy = [0, 1, 0, -1, 0];
final Map<String, int> dirId = {'^': 0, '>': 1, 'v': 2, '<': 3};
final String dirChar = '^>v<';

class Tupla {
  final int x, y, t;

  Tupla(this.x, this.y, this.t);

  @override
  bool operator ==(Object other) =>
      other is Tupla && other.x == x && other.y == y && other.t == t;

  @override
  int get hashCode => Object.hash(x, y, t);
}

late List<String> mapa;
late int m, n;
List<Tupla> posicion = [];
Map<int, Set<Point<int>>> posiCache = {};

Point<int> mover(Tupla cur, int paso) {
  return Point(((cur.x + dx[cur.t] * paso - 1) % (m - 2) + m - 2) % (m - 2) + 1,
      ((cur.y + dy[cur.t] * paso - 1) % (n - 2) + n - 2) % (n - 2) + 1);
}

int bfs(int u0, int v0, int t0, int u, int v) {
  Queue<Tupla> q = Queue.from([Tupla(u0, v0, t0)]);
  Set<Tupla> visitado = {};
  while (q.isNotEmpty) {
    Tupla calle = q.removeFirst();
    posiCache.putIfAbsent(
        calle.t + 1, () => (posicion.map((e) => mover(e, calle.t + 1)).toSet()));
    Set<Point<int>> nievePosicion = posiCache[calle.t + 1]!;
    for (int i = 0; i < 5; ++i) {
      int i2 = calle.x + dx[i], j2 = calle.y + dy[i];
      Tupla st2 = Tupla(i2, j2, calle.t + 1);
      if (i2 >= 0 &&
          i2 < m &&
          mapa[i2][j2] != '#' &&
          !nievePosicion.contains(Point(i2, j2)) &&
          !visitado.contains(st2)) {
        if (i2 == u && j2 == v) {
          return calle.t + 1;
        }
        visitado.add(st2);
        q.addLast(st2);
      }
    }
  }
  return -1;
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia24.txt');
  mapa = file.readAsLinesSync();
  m = mapa.length;
  n = mapa[0].length;
  for (int i = 0; i < m; ++i) {
    for (int j = 0; j < n; ++j) {
      if (dirId.containsKey(mapa[i][j])) {
        posicion.add(Tupla(i, j, dirId[mapa[i][j]]!));
      }
    }
  }

  print(" Dia 24: ");
  int result = bfs(0, 1, 0, m - 1, n - 2);
  print('   $result');

  int result2 = bfs(m - 1, n - 2, result, 0, 1);
  result2 = bfs(0, 1, result2, m - 1, n - 2);
  print('   $result2');
}
