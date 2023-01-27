import 'dart:io';
import 'dart:math';

final bool parte1 = false;
final int nRondas = parte1 ? 10 : inf;
final List<int> dx = [-1, -1, -1, 0, 0, 1, 1, 1];
final List<int> dy = [-1, 0, 1, -1, 1, -1, 0, 1];
final List<List<int>> dirGrupos = [
  [0, 1, 2],
  [5, 6, 7],
  [0, 3, 5],
  [2, 4, 7]
];
final int inf = 1000000000;

Set<Point<int>> pos = {};

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia23.txt');
  List<String> mapa = file.readAsLinesSync();
  for (int i = 0; i < mapa.length; ++i) {
    for (int j = 0; j < mapa[i].length; ++j) {
      if (mapa[i][j] == '#') {
        pos.add(Point(i, j));
      }
    }
  }

  for (int i = 0; i < nRondas; ++i) {
    Map<Point<int>, Point<int>> obj = {};
    Map<Point<int>, int> cuenta = {};
    pos.forEach((p) {
      List<bool> bloqueo = List.generate(
          8, (j) => pos.contains(Point(p.x + dx[j], p.y + dy[j])));
      if (bloqueo.indexWhere((element) => element) == -1) {
        return;
      }

      for (int j = 0; j < dirGrupos.length; ++j) {
        if (dirGrupos[j].indexWhere((element) => bloqueo[element]) == -1) {
          int d = dirGrupos[j][1];
          Point<int> pro = Point(p.x + dx[d], p.y + dy[d]);
          obj[p] = pro;
          cuenta[pro] = (cuenta[pro] ?? 0) + 1;
          break;
        }
      }
    });

    Set<Point<int>> nuevaPos = pos
        .map((e) => obj.containsKey(e) && cuenta[obj[e]!] == 1
            ? obj[e]!
            : e)
        .toSet();
    if (nuevaPos.difference(pos).isEmpty) {
      print(i + 1);
      exit(0);
    }
    pos = nuevaPos;

    var temp = dirGrupos[0];
    dirGrupos.removeAt(0);
    dirGrupos.add(temp);
  }

  int minx = pos.fold<int>(inf, (minx, element) => min(minx, element.x));
  int maxx = pos.fold<int>(-inf, (maxx, element) => max(maxx, element.x));
  int miny = pos.fold<int>(inf, (miny, element) => min(miny, element.y));
  int maxy = pos.fold<int>(-inf, (maxy, element) => max(maxy, element.y));

  print(" Dia 23: ");
  var result = (maxx - minx + 1) * (maxy - miny + 1) - pos.length;
  print('   $result');
  
}
