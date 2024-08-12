import 'package:gato/importDeImports.dart';


class Botones extends StatefulWidget {
  final Function(String) onGameEnd;
  final Function() onMove;

  const Botones({super.key, required this.onGameEnd, required this.onMove});

  @override
  BotonesState createState() => BotonesState();
}

class BotonesState extends State<Botones> {
  double ancho = 0, alto = 0;
  estados inicial = estados.x;
  int clicks = 0;

  @override
  void initState() {
    super.initState();
    reiniciarTablero();
  }

  @override
  Widget build(BuildContext context) {
    ancho = MediaQuery.of(context).size.width;
    alto = MediaQuery.of(context).size.height;
    return SizedBox(
      width: ancho,
      height: ancho,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Celda(inicial: tablero[0], espacio: ancho / 3, clicked: () => clicked(0)),
                Celda(inicial: tablero[1], espacio: ancho / 3, clicked: () => clicked(1)),
                Celda(inicial: tablero[2], espacio: ancho / 3, clicked: () => clicked(2)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Celda(inicial: tablero[3], espacio: ancho / 3, clicked: () => clicked(3)),
                Celda(inicial: tablero[4], espacio: ancho / 3, clicked: () => clicked(4)),
                Celda(inicial: tablero[5], espacio: ancho / 3, clicked: () => clicked(5)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Celda(inicial: tablero[6], espacio: ancho / 3, clicked: () => clicked(6)),
                Celda(inicial: tablero[7], espacio: ancho / 3, clicked: () => clicked(7)),
                Celda(inicial: tablero[8], espacio: ancho / 3, clicked: () => clicked(8)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void clicked(int index) {
    if (tablero[index] == estados.vacio) {
      setState(() {
        tablero[index] = inicial;
        clicks++;
      });

      estados ganador = buscarGanador();
      if (ganador != estados.vacio) {
        String mensaje = "El ganador es: ${ganador == estados.x ? "X" : "O"}";
        widget.onGameEnd(mensaje);
        if (ganador == estados.x) {
          winsX++;
        } else {
          winsO++;
        }
      } else if (clicks == 9) {
        widget.onGameEnd("Es un empate");
        draws++;
      } else {
        setState(() {
          inicial = inicial == estados.x ? estados.o : estados.x;
        });
        widget.onMove();
      }
    }
  }

  estados buscarGanador() {
    // Verificar filas
    for (int i = 0; i < 9; i += 3) {
      if (sonIguales(i, i + 1, i + 2)) {
        return tablero[i];
      }
    }
    // Verificar columnas
    for (int i = 0; i < 3; i++) {
      if (sonIguales(i, i + 3, i + 6)) {
        return tablero[i];
      }
    }
    // Verificar diagonales
    if (sonIguales(0, 4, 8)) {
      return tablero[0];
    }
    if (sonIguales(2, 4, 6)) {
      return tablero[2];
    }
    return estados.vacio;
  }

  bool sonIguales(int a, int b, int c) {
    return tablero[a] != estados.vacio && tablero[a] == tablero[b] && tablero[a] == tablero[c];
  }

  void reiniciarTablero() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        tablero[i] = estados.vacio;
      }
      clicks = 0;
      inicial = estados.x;
    });
  }
}
