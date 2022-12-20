import 'dart:io';
import 'dart:math';

const int fsSize = 70000000;
const int reqSize = 30000000;

class Directory {
  int size = 0;
  Map<String, Directory> hijo = {};
  Directory? padre;
  late int totalSize = hijo.values.fold<int>(size, (int suma, Directory hijo) => suma + hijo.totalSize);
}

void addHijo(Directory p, String nombreHijo, List<Directory> allDirs) {
  if (p.hijo.containsKey(nombreHijo)) {
    return;
  }
  Directory hijo = Directory();
  hijo.padre = p;
  p.hijo[nombreHijo] = hijo;
  allDirs.add(hijo);
}

void main() {
  File file = File('../advent_of_code/lib/2022/data/dia07.txt');
  Directory root = Directory();
  Directory dirActual = root;
  List<Directory> allDirs = [root];

  for (String linea in file.readAsLinesSync()) {
    List<String> tokens = linea.split(' ');
    if (tokens[0] == '\$' && tokens[1] == 'cd') {
      if (tokens[2] == '..') {
        dirActual = dirActual.padre!;
      } else if (tokens[2] == '/') {
        dirActual = root;
      } else {
        addHijo(dirActual, tokens[2], allDirs);
        dirActual = dirActual.hijo[tokens[2]]!;
      }
    } else if (tokens[0] != '\$' && tokens[0] != 'dir') {
      dirActual.size += int.parse(tokens[0]);
    }
  }

  print(" Dia 7: ");
  var result = allDirs.where((dir) => dir.totalSize <= 100000).fold<int>(0, (sum, dir) => sum + dir.totalSize);
  print('   $result');

  int minSize = reqSize - (fsSize - root.totalSize);
  var result2 = allDirs.where((dir) => dir.totalSize >= minSize).fold<int>(root.totalSize, (res, dir) => min(res, dir.totalSize));
  print('   $result2');
}
