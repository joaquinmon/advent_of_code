import 'dart:io';

final bool parte1 = false;
final int nMx = parte1 ? 1 : 10;

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia20.txt');
  List<int> numeros = file.readAsLinesSync().map((e) => int.parse(e)).toList();
  if (!parte1) {
    numeros = numeros.map((e) => e * 811589153).toList();
  }
  int n = numeros.length;
  List<int> posicion = List.generate(n, (index) => index);
  List<int> idx = List.generate(n, (index) => index);
  for (int mix = 0; mix < nMx; ++mix) {
    for (int i = 0; i < n; ++i) {
      int j = posicion[i];
      int k = (numeros[j] % (n - 1) + (n - 1)) % (n - 1);
      for (int u = 0; u < k; ++u) {
        int j2 = (j + 1) % n;
        int temp = numeros[j];
        numeros[j] = numeros[j2];
        numeros[j2] = temp;
        int i2 = idx[j2];
        idx[j] = i2;
        idx[j2] = i;
        posicion[i] = j2;
        posicion[i2] = j;
        j = j2;
      }
    }
  }
  int p0 = numeros.indexOf(0);
  print(" Dia 20: ");
  var result = numeros[(p0 + 1000) % n] + numeros[(p0 + 2000) % n] + numeros[(p0 + 3000) % n];
  print('   $result');
}
