import 'package:flutter/material.dart';

class GestionarTiposScreen extends StatefulWidget {
  final Map<String, double> tipos;
  final Function(Map<String, double>) onGuardar;

  GestionarTiposScreen({required this.tipos, required this.onGuardar});

  @override
  _GestionarTiposScreenState createState() => _GestionarTiposScreenState();
}

class _GestionarTiposScreenState extends State<GestionarTiposScreen> {
  late Map<String, double> tiposEditables;
  final tipoCtrl = TextEditingController();
  final precioCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    tiposEditables = Map.from(widget.tipos);
  }

  void agregarTipo() {
    final tipo = tipoCtrl.text.trim();
    final precio = double.tryParse(precioCtrl.text);
    if (tipo.isNotEmpty && precio != null) {
      setState(() {
        tiposEditables[tipo] = precio;
      });
      tipoCtrl.clear();
      precioCtrl.clear();
    }
  }

  void eliminarTipo(String tipo) {
    setState(() {
      tiposEditables.remove(tipo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tipos de trabajo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tipoCtrl,
                    decoration: InputDecoration(labelText: 'Tipo de trabajo'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: precioCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Precio/m²'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: agregarTipo,
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: tiposEditables.entries.map((e) {
                  return ListTile(
                    title: Text(e.key),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('€${e.value.toStringAsFixed(2)}'),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => eliminarTipo(e.key),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onGuardar(tiposEditables);
                Navigator.pop(context);
              },
              child: Text('Guardar cambios'),
            )
          ],
        ),
      ),
    );
  }
}