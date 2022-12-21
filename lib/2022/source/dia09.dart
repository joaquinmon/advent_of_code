import 'dart:io';
import 'dart:math';

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia09.txt');

  Map<String, Coord> dir = {
    'U': Coord(0, 1),
    'D': Coord(0, -1),
    'L': Coord(-1, 0),
    'R': Coord(1, 0)
  };

  Cuerda cuerda = Cuerda(2);
  Cuerda cuerda2 = Cuerda(10);

  Set<Coord> visita = {Coord(0, 0)};
  Set<Coord> visita2 = {Coord(0, 0)};

  for (String linea in file.readAsLinesSync()) {
    List<String> tokens = linea.split(' ');
    int n = int.parse(tokens[1]);
    Coord d = dir[tokens[0]]!;

    for (int i = 1; i <= n; ++i) {
      cuerda.move(d);
      visita.add(Coord(cuerda.tail().x, cuerda.tail().y));
      cuerda2.move(d);
      visita2.add(Coord(cuerda2.tail().x, cuerda2.tail().y));
    }
  }

  var result = visita.length;
  var result2 = visita2.length;
  print(" Dia 9: ");
  print('   $result');
  print('   $result2');
}

class Coord extends Point<int> {
  Coord(int x, int y) : super(x, y);

  Coord moveDir(Coord dir) {
    return Coord(x + dir.x, y + dir.y);
  }

  Coord moveTowards(Coord otro) {
    int dirx = otro.x - x;
    int diry = otro.y - y;
    return Coord(x + (dirx != 0 ? dirx ~/ dirx.abs() : 0),
        y + (diry != 0 ? diry ~/ diry.abs() : 0));
  }
}

class Cuerda {
  List<Coord> nudos;

  Cuerda(int n) : nudos = List.generate(n, (_) => Coord(0, 0));

  Coord tail() {
    return nudos.last;
  }

  void move(Coord dir) {
    nudos.first = nudos.first.moveDir(dir);
    for (int i = 1; i < nudos.length; ++i) {
      if (nudos[i].squaredDistanceTo(nudos[i - 1]) > 2) {
        nudos[i] = nudos[i].moveTowards(nudos[i - 1]);
      }
    }
  }
}
