import 'package:flutter/material.dart';
import '../models/trabajo.dart';

class AgregarTrabajoScreen extends StatefulWidget {
  final Function(Trabajo) onGuardar;

  AgregarTrabajoScreen({required this.onGuardar});

  @override
  _AgregarTrabajoScreenState createState() => _AgregarTrabajoScreenState();
}

class _AgregarTrabajoScreenState extends State<AgregarTrabajoScreen> {
  final _formKey = GlobalKey<FormState>();
  String tipo = 'Pisos';
  double metros = 0;
  double precio = 0;
  DateTime fecha = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Trabajo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: tipo,
                items: ['Pisos', 'Paredes', 'Zócalo', 'Escalera']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => tipo = val!),
                decoration: InputDecoration(labelText: 'Tipo de trabajo'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Metros cuadrados'),
                keyboardType: TextInputType.number,
                onSaved: (val) => metros = double.parse(val!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Precio por metro'),
                keyboardType: TextInputType.number,
                onSaved: (val) => precio = double.parse(val!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  final nuevo = Trabajo(
                    tipo: tipo,
                    metros: metros,
                    precio: precio,
                    fecha: fecha,
                  );
                  widget.onGuardar(nuevo);
                  Navigator.pop(context);
                },
                child: Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}