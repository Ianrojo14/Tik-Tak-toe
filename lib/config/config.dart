

library config.globals;

enum estados { vacio, x, o }

List<estados> tablero = List.filled(9, estados.vacio);

Map<estados, bool> ganador = {
  estados.o: false,
  estados.x: false,
  estados.vacio: false,
};

int winsX = 0;
int winsO = 0;
int draws = 0;

