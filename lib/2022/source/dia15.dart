import 'dart:async';
import 'dart:io';
import 'dart:math';

class Sensor {
  Point<int> sensor;
  Point<int> beacon;
  int distancia = 0;
  Sensor(this.sensor, this.beacon) {
    distancia = (sensor.x - beacon.x).abs() +
        (sensor.y - beacon.y).abs();
  }
  int getDistancia(Point<int> p2) {
    return (sensor.x - p2.x).abs() + (sensor.y - p2.y).abs();
  }

  @override
  String toString() {
    return 'Sensor: $sensor - Beacon: $beacon - Distance: $distancia';
  }
}

Future<void> main() async {
  String input = await File('../advent_of_code/lib/2022/data/dia15.txt').readAsString();
  List<Sensor> sensores = parseInput(input);
  print(" Dia 15: ");
  print('   ${parte1(sensores)}');
  print('   ${parte2(sensores)}');
}

List<Sensor> parseInput(String input) {
  List<Sensor> result = [];
  RegExp regex =
      RegExp(r'Sensor at x=(.*), y=(.*): closest beacon is at x=(.*), y=(.*)');
  regex.allMatches(input).forEach((m) {
    int x1 = int.parse(m[1]!);
    int y1 = int.parse(m[2]!);
    int x2 = int.parse(m[3]!);
    int y2 = int.parse(m[4]!);
    result.add(Sensor(Point(x1, y1), Point(x2, y2)));
  });
  return result;
}

int getMaxDerecha(List<Sensor> sensores) {
  int result = 0;
  for (var s in sensores) {
    if (result < s.sensor.x + s.distancia) result = s.sensor.x + s.distancia;
  }
  return result;
}

int getMaxIzquierda(List<Sensor> sensores, int principio) {
  for (var s in sensores) {
    if (principio > s.sensor.x - s.distancia) principio = s.sensor.x - s.distancia;
  }
  return principio;
}

int parte1(List<Sensor> sensores) {
  const int fila = 2000000;
  // const int row = 10;
  int maxDerecha = getMaxDerecha(sensores);
  int maxIzquierda = getMaxIzquierda(sensores, maxDerecha);
  int result = 0;
  for (int i = maxIzquierda; i <= maxDerecha; i++) {
    for (Sensor s in sensores) {
      if (s.distancia >= s.getDistancia(Point(i, fila)) &&
          Point(i, fila) != s.beacon) {
        result++;
        break;
      }
    }
  }
  return result;
}

int parte2(List<Sensor> sensores) {
  // const int maxN = 20;
  const int maxN = 4000000;
  bool esEncontrado;
  for (int i = 0; i <= maxN; i++) {
    for (int j = 0; j <= maxN; j++) {
      int saltar = 0;
      esEncontrado = true;
      for (Sensor s in sensores) {
        int dist = s.getDistancia(Point(j, i));
        if (s.distancia >= dist) {
          esEncontrado = false;
          int nSaltar = s.distancia - dist;
          if (s.sensor.x > j) nSaltar += (s.sensor.x - j) * 2;
          if (saltar < nSaltar) saltar = nSaltar;
        }
      }
      if (esEncontrado) {
        return j * 4000000 + i;
      } else {
        j += saltar;
      }
    }
  }
  return 0;
}
