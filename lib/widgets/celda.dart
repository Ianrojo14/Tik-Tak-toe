import 'package:gato/importDeImports.dart';


class Celda extends StatelessWidget {
  final estados? inicial;
  final double? espacio;
  final Function() clicked;

  const Celda({
    required this.inicial,
    required this.espacio,
    required this.clicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: espacio,
      width: espacio,
      child: CupertinoButton(child: seleccionImagen()!, onPressed: clicked),
    );
  }

  Widget? seleccionImagen() {
    if (inicial == estados.vacio) {
      return SizedBox(
        height: espacio,
        width: espacio,
      );
    } else if (inicial == estados.x) {
      return Image.asset("resources/x.png");
    } else {
      return Image.asset("resources/o.png");
    }
  }
}
