import 'dart:io';

Map<String, List<String>> adj = {};
Map<String, List<String>> rAdj = {};
Map<String, String> op = {};
Map<String, int> valor = {};

num calcular(String id) {
  if (valor.containsKey(id)) {
    return valor[id]!;
  }
  List<num> adjValores = adj[id]!.map((e) => calcular(e)).toList();
  String o = op[id]!;
  if (o == '+') {
    return adjValores[0] + adjValores[1];
  } else if (o == '-') {
    return adjValores[0] - adjValores[1];
  } else if (o == '*') {
    return adjValores[0] * adjValores[1];
  } else if (o == '/') {
    return adjValores[0] / adjValores[1];
  } else {
    return adjValores[0];
  }
}

void rOp(String id, String pid) {
  if (adj.containsKey(id)) {
    String o = op[id]!;
    int idx = adj[id]!.indexOf(pid);
    String otro = adj[id]![1 - idx];
    if (o == '+') {
      adj[pid] = [id, otro];
      op[pid] = '-';
    } else if (o == '-') {
      if (idx == 0) {
        adj[pid] = [id, otro];
        op[pid] = '+';
      } else {
        adj[pid] = [otro, id];
        op[pid] = '-';
      }
    } else if (o == '*') {
      adj[pid] = [id, otro];
      op[pid] = '/';
    } else if (o == '/') {
      if (idx == 0) {
        adj[pid] = [id, otro];
        op[pid] = '*';
      } else {
        adj[pid] = [otro, id];
        op[pid] = '/';
      }
    } else {
      adj[pid] = [otro];
      op[pid] = '=';
    }
  }
  if (!rAdj.containsKey(id)) {
    return;
  }
  assert(rAdj[id]!.length == 1);
  rOp(rAdj[id]![0], id);
}

void addRev(String u, String v) {
  rAdj.putIfAbsent(u, () => []);
  rAdj[u]!.add(v);
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia21.txt');
  for (String linea in file.readAsLinesSync()) {
    List<String> token = linea.split(' ');
    String id = token[0].substring(0, token[0].length - 1);
    if (token.length == 2) {
      valor[id] = int.parse(token[1]);
    } else {
      adj[id] = [token[1], token[3]];
      op[id] = token[2];
      addRev(token[1], id);
      addRev(token[3], id);
    }
  }
  print(" Dia 21: ");
  var result = calcular('root').toInt();
  print('   $result');

  op['root'] = '=';
  rOp('humn', '');
  valor.remove('humn');
  var result2 = calcular('humn').toInt();
  print('   $result2');
}
