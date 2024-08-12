import 'package:gato/importDeImports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GlobalKey<BotonesState> _botonesKey;

  @override
  void initState() {
    super.initState();
    _botonesKey = GlobalKey<BotonesState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Gato'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'Reiniciar') {
                mostrarDialogoConfirmacion(
                    context, '¿Desea reiniciar el juego?', reiniciarJuego);
              } else if (result == 'Salir') {
                mostrarDialogoSalir(context, '¿Desea salir del juego?',
                    () {
                  Navigator.of(context).pop();
                  exit(0); // Cerrar la aplicación completamente
                });
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Reiniciar',
                child: Text('Reiniciar'),
              ),
              const PopupMenuItem<String>(
                value: 'Salir',
                child: Text('Salir'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('X wins: $winsX',
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                Text('O wins: $winsO',
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                Text('Draws: $draws',
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "resources/board.png",
                ),
                Botones(
                  key: _botonesKey,
                  onGameEnd: (String mensaje) =>
                      mostrarDialogoFinal(context, mensaje, reiniciarJuego),
                  onMove: () {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => mostrarDialogoConfirmacion(
                  context, '¿Desea reiniciar el juego?', () {
                Navigator.of(context).pop();
                reiniciarJuego2();
              }),
            ),
            IconButton(
              icon: const Icon(Icons.grid_on),
              onPressed: () => mostrarDialogoJuego(
                  context, '¿Deseas jugar otra partida?', () {
                Navigator.of(context).pop();
                reiniciarJuego2();
              }),
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => mostrarDialogoSalir(context, '¿Desea salir del juego?', () {
                Navigator.of(context).pop();
                exit(0); // Cerrar la aplicación completamente
              }),
            ),

          ],
        ),
      ),
    );
  }

  void mostrarDialogoSalir(
      BuildContext context, String mensaje, void Function() reiniciarJuego) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmacion de salida"),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: const Text("No salir"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Salir"),
              onPressed: () {
                Navigator.of(context).pop();
                exit(0); // Cerrar la aplicación completamente
              },
            ),
          ],
        );
      },
    );
  }

  void mostrarDialogoFinal(
      BuildContext context, String mensaje, void Function() reiniciarJuego) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Fin del juego"),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: const Text("Continuar"),
              onPressed: () {
                reiniciarJuego();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Salir"),
              onPressed: () {
                Navigator.of(context).pop();
                exit(0); // Cerrar la aplicación completamente
              },
            ),
          ],
        );
      },
    );
  }

  void mostrarDialogoConfirmacion(
      BuildContext context, String mensaje, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmación"),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Aceptar"),
              onPressed: () {
                reiniciarJuego2();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void mostrarDialogoJuego(
      BuildContext context, String mensaje, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("New Game"),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                reiniciarJuego2();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void reiniciarJuego() {
    _botonesKey.currentState?.reiniciarTablero();
  }

  void reiniciarEstadisticas() {
    winsX = 0;
    winsO = 0;
    draws = 0;
  }

  void reiniciarJuego2() {
    _botonesKey.currentState?.reiniciarTablero();
    reiniciarEstadisticas();
    setState(() {});
  }
}
