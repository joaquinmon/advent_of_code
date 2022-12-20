import 'dart:io';
import 'dart:math';



main() async {
  File file = File('../advent_of_code/lib/2022/data/dia05.txt');
  List<String> lineas = File(file.path).readAsLinesSync();
  List<String> boxLineas = lineas.take(9).toList();

  Map<String, List<String>> pila = {};
  Map<String, List<String>> pila2 = {};
  int lineaLargo = boxLineas.first.length;

  for (var columnaIdex = 1; columnaIdex < lineaLargo; columnaIdex += 4) {
    String pilaIndex =
        boxLineas[boxLineas.length - 1].substring(columnaIdex, columnaIdex + 1);
    
    for (var filaIndex = boxLineas.length - 2; filaIndex >= 0; filaIndex--) {
      String valor = boxLineas[filaIndex].substring(columnaIdex, columnaIdex + 1);
      
      if (valor != " ") {
        pila[pilaIndex] = (pila[pilaIndex] ?? [])
          ..add(boxLineas[filaIndex].substring(columnaIdex, columnaIdex + 1));

        pila2[pilaIndex] = (pila2[pilaIndex] ?? [])
          ..add(boxLineas[filaIndex].substring(columnaIdex, columnaIdex + 1));
      }
    }
  }

  List<String> ordenLineas = lineas.sublist(10).toList();
  int moverIndex = 1;
  int desdeIndex = 3;
  int haciaIndex = 5;

  for (var linea in ordenLineas) {
    
    List<String> ordeb = linea.split(" ");
    int moverCantidad = int.parse(ordeb[moverIndex]);
    String desdeKey = ordeb[desdeIndex];
    String haciaKey = ordeb[haciaIndex];

    List<String> data = pila[desdeKey] ?? [];
    List<String> data2 = pila2[desdeKey] ?? [];

    List<String> dataEnvio =
        data.getRange(max(data.length - moverCantidad, 0), data.length).toList();
    List<String> dataEnvio2 =
        data2.getRange(max(data2.length - moverCantidad, 0), data2.length).toList();

    pila[desdeKey] = data
      ..removeRange(max(data.length - moverCantidad, 0), data.length);
    pila2[desdeKey] = data2
      ..removeRange(max(data2.length - moverCantidad, 0), data2.length);

    // Parte 1
     pila[haciaKey] = (pila[haciaKey] ?? [])..addAll(dataEnvio.reversed);
    // Parte 2
    pila2[haciaKey] = (pila2[haciaKey] ?? [])..addAll(dataEnvio2);
  }

  String result = "";
  String result2 = "";
  for (String key in pila.keys) {
    result += pila[key]?.last ?? "";
    result2 += pila2[key]?.last ?? "";
  }
  print(" Dia 5: ");
  print('   $result'); 
  print('   $result2');
}
