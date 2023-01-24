import 'dart:io';
import 'dart:math';

final bool parte1 = false;
final int T = parte1 ? 24 : 32;
final RegExp numExp = RegExp(r'[0-9]+');

class Estado {
  final int t;
  final int ore, clay, obs;
  final int oreRobot, clayRobot, obsRobot, geoRobot;

  Estado(this.t, this.ore, this.clay, this.obs, this.oreRobot, this.clayRobot,
      this.obsRobot, this.geoRobot);

  @override
  bool operator ==(Object other) =>
      other is Estado &&
      other.t == t &&
      other.ore == ore &&
      other.clay == clay &&
      other.obs == obs &&
      other.oreRobot == oreRobot &&
      other.clayRobot == clayRobot &&
      other.obsRobot == obsRobot &&
      other.geoRobot == geoRobot;

  @override
  int get hashCode =>
      Object.hash(t, ore, clay, obs, oreRobot, clayRobot, obsRobot, geoRobot);
}

late int oreCost, clayCost, obsOreCost, obsClayCost, geoOreCost, geoObsCost;
Map<Estado, int> dp = {};

int calcular(Estado estado) {
  if (estado.t == 0) {
    return 0;
  }
  if (dp.containsKey(estado)) {
    return dp[estado]!;
  }
  int result = 0;
  if (estado.ore >= geoOreCost && estado.obs >= geoObsCost) {
    return dp[estado] = estado.geoRobot +
        calcular(Estado(
            estado.t - 1,
            estado.ore + estado.oreRobot - geoOreCost,
            estado.clay + estado.clayRobot,
            estado.obs + estado.obsRobot - geoObsCost,
            estado.oreRobot,
            estado.clayRobot,
            estado.obsRobot,
            estado.geoRobot + 1));
  }
  if (estado.ore >= obsOreCost && estado.clay >= obsClayCost) {
    return dp[estado] = estado.geoRobot +
        calcular(Estado(
            estado.t - 1,
            estado.ore + estado.oreRobot - obsOreCost,
            estado.clay + estado.clayRobot - obsClayCost,
            estado.obs + estado.obsRobot,
            estado.oreRobot,
            estado.clayRobot,
            estado.obsRobot + 1,
            estado.geoRobot));
  }
  if (estado.ore >= clayCost) {
    result = estado.geoRobot +
        calcular(Estado(
            estado.t - 1,
            estado.ore + estado.oreRobot - clayCost,
            estado.clay + estado.clayRobot,
            estado.obs + estado.obsRobot,
            estado.oreRobot,
            estado.clayRobot + 1,
            estado.obsRobot,
            estado.geoRobot));
  }
  if (estado.ore >= oreCost) {
    result = max(
        result,
        estado.geoRobot +
            calcular(Estado(
                estado.t - 1,
                estado.ore + estado.oreRobot - oreCost,
                estado.clay + estado.clayRobot,
                estado.obs + estado.obsRobot,
                estado.oreRobot + 1,
                estado.clayRobot,
                estado.obsRobot,
                estado.geoRobot)));
  }
  result = max(
      result,
      estado.geoRobot +
          calcular(Estado(
              estado.t - 1,
              estado.ore + estado.oreRobot,
              estado.clay + estado.clayRobot,
              estado.obs + estado.obsRobot,
              estado.oreRobot,
              estado.clayRobot,
              estado.obsRobot,
              estado.geoRobot)));

  return dp[estado] = result;
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia19.txt');
  int result = 0;
  List<int> result2 = [];
  for (String linea in file.readAsLinesSync()) {
    dp.clear();
    List<int> numeros =
        numExp.allMatches(linea).map((e) => int.parse(e.group(0)!)).toList();
    oreCost = numeros[1];
    clayCost = numeros[2];
    obsOreCost = numeros[3];
    obsClayCost = numeros[4];
    geoOreCost = numeros[5];
    geoObsCost = numeros[6];

    int temp = calcular(Estado(T, 0, 0, 0, 1, 0, 0, 0));
    result += numeros[0] * temp;

    result2.add(temp);
    if (!parte1 && result2.length == 3) {
      break;
    }
  }
  print(' Dia 19: ');
  if (parte1) {
    print('   $result');
  } else {
    var resul2 = result2[0] * result2[1] * result2[2];
    print('   $resul2');
  }
}
