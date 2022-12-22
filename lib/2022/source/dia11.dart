import 'dart:collection';
import 'dart:io';

//Para ver el resultado de la parte 1 tiene que esta asignado en true, para la parte 2 en false
final bool parte1 = false;
final int nRondas = parte1 ? 20 : 10000;
final int mod = 9699690;

class Mono {
  final Queue<int> objetos;
  final String operacion;
  final int opValor;
  final int pruebaValor;
  final int siTirar, noTirar;

  Mono(this.objetos, this.operacion, this.opValor, this.pruebaValor, this.siTirar,
      this.noTirar);

  void monoHaceCosas(List<Mono> monos) {
    while (objetos.isNotEmpty) {
      int x = objetos.removeFirst();
      if (operacion == '+') {
        x = (x + opValor) % mod;
      } else if (operacion == '*') {
        x = (x * opValor) % mod;
      } else {
        x = (x * x) % mod;
      }
      if (parte1) {
        x ~/= 3;
      }
      if (x % pruebaValor == 0) {
        monos[siTirar].objetos.addLast(x);
      } else {
        monos[noTirar].objetos.addLast(x);
      }
    }
  }
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia11.txt');
  List<String> lineas = file.readAsLinesSync();
  List<Mono> monos = [];
  for (int i = 0; i + 5 < lineas.length; i += 7) {
    Queue<int> objetos = Queue.from(lineas[i + 1]
        .trimLeft()
        .split(' ')
        .sublist(2)
        .map((e) => int.parse(e.replaceAll(',', ''))));
    List<String> tmp = lineas[i + 2].trimLeft().split(' ');
    String operacion = '';
    int opValor = 1;
    if (tmp.last != 'old') {
      operacion = tmp[4];
      opValor = int.parse(tmp.last);
    } else {
      // old * old
      operacion = '^';
      opValor = 2;
    }
    int testVal = int.parse(lineas[i + 3].split(' ').last);
    int siTirar = int.parse(lineas[i + 4].split(' ').last);
    int noTirar = int.parse(lineas[i + 5].split(' ').last);
    monos.add(Mono(objetos, operacion, opValor, testVal, siTirar, noTirar));
  }

  List<int> cnt = List.filled(monos.length, 0);
  for (int i = 1; i <= nRondas; ++i) {
    for (int j = 0; j < monos.length; ++j) {
      cnt[j] += monos[j].objetos.length;
      monos[j].monoHaceCosas(monos);
    }
  }
  
  //print(cnt);
  cnt.sort();
  
  var result = cnt.last * cnt[cnt.length - 2];
  print(" Dia 11: ");
  print('   $result');
}
