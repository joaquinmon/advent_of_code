import 'dart:collection';
import 'dart:io';

Future<List<String>> readLines(String filename) async {
  String contenido = await File(filename).readAsString();
  return contenido.split('\n');
}

class Cubo {
  late List<int> pos;

  Cubo(Iterable<int> t) {
    pos = List.from(t);
  }

  static Cubo parse(String linea) {
    return Cubo(linea.split(",").map(int.parse));
  }

  @override
  bool operator ==(Object other) {
    Cubo otro = other as Cubo;
    return pos[0] == otro.pos[0] &&
        pos[1] == otro.pos[1] &&
        pos[2] == otro.pos[2];
  }

  @override
  int get hashCode => Object.hash(pos[0], pos[1], pos[2]);

  @override
  String toString() => "$pos";

  Iterable<Cubo> getVecino() sync* {
    for (int d in [0, 1, 2]) {
      for (int delta in [-1, 1]) {
        Cubo c = Cubo(pos);
        c.pos[d] += delta;
        yield c;
      }
    }
  }
}

void main() async {
  List<String> entradas = await readLines('../advent_of_code/lib/2022/data/dia18.txt');
  var cubos = entradas.map((i) => Cubo.parse(i)).toSet();
  int result = 6 * cubos.length;
  for (var c in cubos) {
    for (var next in c.getVecino()) {
      if (cubos.contains(next)) result--;
    }
  }
  print(" Dia 18: ");
  print('   $result');

  Cubo minEsquina = Cubo([-1, -1, -1]);
  Cubo maxEsquina = Cubo([23, 23, 23]);
  Queue siguiente = Queue();
  siguiente.add(minEsquina);
  Set<Cubo> exterior = HashSet();
  exterior.add(minEsquina);
  while (siguiente.isNotEmpty) {
    Cubo cur = siguiente.removeFirst();
    for (var c in cur.getVecino()) {
      bool valido = true;
      for (int d in [0, 1, 2]) {
        if (c.pos[d] < minEsquina.pos[d] || c.pos[d] > maxEsquina.pos[d]) {
          valido = false;
        }
      }
      if (cubos.contains(c)) valido = false;
      if (exterior.contains(c)) valido = false;
      if (valido) {
        siguiente.addLast(c);
        exterior.add(c);
      }
    }
  }

  result = 0;
  for (var c in cubos) {
    for (var next in c.getVecino()) {
      if (exterior.contains(next)) result++;
    }
  }
  print('   $result');
 
}
