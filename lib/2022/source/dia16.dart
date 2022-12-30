import 'dart:io';
import 'dart:math';

final RegExp numExp = RegExp(r'-?[0-9]+');

late List<List<List<int>>> dp;
Map<String, int> id = {};
int nNodos = 0;
List<int> rates = [];
List<List<String>> adj = [];
int nValves = 0;
List<int> nodoToValve = [];

int calcular(int tiempo, int masc, int pos) {
  if (tiempo == 0) {
    return 0;
  }
  int res = dp[tiempo][masc][pos];
  if (res >= 0) {
    return res;
  }
  res = 0;
  if (nodoToValve[pos] != -1 && ((masc >> nodoToValve[pos]) & 1) == 0) {
    int mask2 = masc | (1 << nodoToValve[pos]);
    res = max(res, calcular(tiempo - 1, mask2, pos) + (tiempo - 1) * rates[pos]);
  }
  for (String nodo in adj[pos]) {
    res = max(res, calcular(tiempo - 1, masc, id[nodo]!));
  }
  return dp[tiempo][masc][pos] = res;
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia16.txt');

  for (String linea in file.readAsLinesSync()) {
    List<String> tokens = linea.split(' ');
    String node = tokens[1];
    nNodos++;
    id[node] = nNodos - 1;

    int rate = int.parse(numExp.firstMatch(tokens[4])!.group(0)!);
    rates.add(rate);

    if (rate > 0) {
      nValves++;
      nodoToValve.add(nValves - 1);
    } else {
      nodoToValve.add(-1);
    }

    adj.add([]);
    for (int i = 9; i < tokens.length; ++i) {
      adj.last.add(tokens[i].replaceAll(',', ''));
    }
  }

  dp = List.generate(
      31, (_) => List.generate(1 << nValves, (_) => List.filled(nNodos, -1)));
      print(" Dia 16: ");
  // parte 1
  var result = calcular(30, 0, id['AA']!);
  print('   $result');

  // parte 2
  int result2 = 0;
  for (int personaMasc = 0; personaMasc < (1 << nValves); ++personaMasc) {
    int elefanteMasc = ((1 << nValves) - 1) ^ personaMasc;
    result2 = max(
        result2, calcular(26, personaMasc, id['AA']!) + calcular(26, elefanteMasc, id['AA']!));
  }
  print('   $result2');
}
