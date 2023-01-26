import 'dart:io';

final bool parte1 = false;
final RegExp nXp = RegExp(r'[0-9]+');
final RegExp dXp = RegExp(r'[LR]');
final List<int> dx = [0, 1, 0, -1];
final List<int> dy = [1, 0, -1, 0];
final int cubo = 50;

class Estado {
  final int x, y, d;

  Estado(this.x, this.y, this.d);
}

late List<String> mapa;
late List<int> pasos;
late List<String> dir;
late List<int> izq, der, arriba, bajo;

Estado mov1(Estado cur) {
  int i2 = cur.x + dx[cur.d], j2 = cur.y + dy[cur.d];
  if (i2 > bajo[cur.y]) {
    i2 = arriba[cur.y];
  } else if (i2 < arriba[cur.y]) {
    i2 = bajo[cur.y];
  }
  if (j2 < izq[cur.x]) {
    j2 = der[cur.x];
  } else if (j2 > der[cur.x]) {
    j2 = izq[cur.x];
  }
  return Estado(i2, j2, cur.d);
}

int getLado(Estado cur) {
  if (cur.x < cubo) {
    return cur.y ~/ cubo;
  }
  if (cur.x < 2 * cubo) {
    return 3;
  }
  if (cur.x < 3 * cubo) {
    return cur.y ~/ cubo + 4;
  }
  return 6;
}

Estado mov1Parte2(Estado cur) {
  if (cur.x + dx[cur.d] >= arriba[cur.y] &&
      cur.x + dx[cur.d] <= bajo[cur.y] &&
      cur.y + dy[cur.d] >= izq[cur.x] &&
      cur.y + dy[cur.d] <= der[cur.x]) {
    return Estado(cur.x + dx[cur.d], cur.y + dy[cur.d], cur.d);
  }
  int lado = getLado(cur);
  switch (lado) {
    case 1:
      return cur.d == 2
          ? Estado(3 * cubo - 1 - cur.x, 0, 0)
          : Estado(cur.y + 2 * cubo, 0, 0); // d == 3
    case 2:
      switch (cur.d) {
        case 0:
          return Estado(3 * cubo - 1 - cur.x, 2 * cubo - 1, 2);
        case 1:
          return Estado(cur.y - cubo, 2 * cubo - 1, 2);
        case 3:
          return Estado(4 * cubo - 1, cur.y - 2 * cubo, 3);
      }
      throw Exception();
    case 3:
      return cur.d == 0
          ? Estado(cubo - 1, cur.x + cubo, 3)
          : Estado(2 * cubo, cur.x - cubo, 1); // d == 2
    case 4:
      return cur.d == 2
          ? Estado(3 * cubo - 1 - cur.x, cubo, 0)
          : Estado(cur.y + cubo, cubo, 0); // d == 3
    case 5:
      return cur.d == 0
          ? Estado(3 * cubo - 1 - cur.x, 3 * cubo - 1, 2)
          : Estado(cur.y + 2 * cubo, cubo - 1, 2); // d == 1
    default:
      switch (cur.d) {
        case 0:
          return Estado(3 * cubo - 1, cur.x - 2 * cubo, 3);
        case 1:
          return Estado(0, cur.y + 2 * cubo, 1);
        case 2:
          return Estado(0, cur.x - 2 * cubo, 1);
      }
      throw Exception();
  }
}

Estado mover(Estado cur, int pasos) {
  for (int k = 0; k < pasos; ++k) {
    Estado siguiente = parte1 ? mov1(cur) : mov1Parte2(cur);
    if (mapa[siguiente.x][siguiente.y] == '#') {
      break;
    }
    cur = siguiente;
  }
  return cur;
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia22.txt');
  List<String> lineas = file.readAsLinesSync();
  mapa = lineas.sublist(0, lineas.length - 2);
  pasos =
      nXp.allMatches(lineas.last).map((e) => int.parse(e.group(0)!)).toList();
  dir = dXp.allMatches(lineas.last).map((e) => e.group(0)!).toList();

  izq = mapa
      .map((e) => e.split('').indexWhere((element) => element != ' '))
      .toList();
  der = mapa.map((e) => e.length - 1).toList();
  arriba = [];
  bajo = [];
  for (int i = 0; i < 3 * cubo; ++i) {
    arriba.add(mapa
        .indexWhere((element) => element.length >= i + 1 && element[i] != ' '));
    bajo.add(mapa.lastIndexWhere(
        (element) => element.length >= i + 1 && element[i] != ' '));
  }

  Estado cur = Estado(0, izq[0], 0);
  cur = mover(cur, pasos[0]);

  for (int i = 0; i < dir.length; ++i) {
    if (dir[i] == 'L') {
      cur = Estado(cur.x, cur.y, (cur.d + 3) % 4);
    } else {
      cur = Estado(cur.x, cur.y, (cur.d + 1) % 4);
    }
    cur = mover(cur, pasos[i + 1]);
  }

  print(" Dia 21: ");
  var result = 1000 * (cur.x + 1) + 4 * (cur.y + 1) + cur.d;
  print('   $result');
  
}
