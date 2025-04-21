import 'package:flutter/material.dart';
import '../models/usuario.dart';

class PerfilUsuarioScreen extends StatefulWidget {
  final Usuario usuario;
  final Function(Usuario) onGuardar;

  PerfilUsuarioScreen({required this.usuario, required this.onGuardar});

  @override
  _PerfilUsuarioScreenState createState() => _PerfilUsuarioScreenState();
}

class _PerfilUsuarioScreenState extends State<PerfilUsuarioScreen> {
  late TextEditingController nombreCtrl;
  late TextEditingController telefonoCtrl;
  late TextEditingController correoCtrl;
  late TextEditingController direccionCtrl;

  @override
  void initState() {
    super.initState();
    nombreCtrl = TextEditingController(text: widget.usuario.nombre);
    telefonoCtrl = TextEditingController(text: widget.usuario.telefono);
    correoCtrl = TextEditingController(text: widget.usuario.correo);
    direccionCtrl = TextEditingController(text: widget.usuario.direccionFiscal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nombreCtrl, decoration: InputDecoration(labelText: 'Nombre')),
            TextField(controller: telefonoCtrl, decoration: InputDecoration(labelText: 'Teléfono')),
            TextField(controller: correoCtrl, decoration: InputDecoration(labelText: 'Correo')),
            TextField(controller: direccionCtrl, decoration: InputDecoration(labelText: 'Dirección Fiscal')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final actualizado = Usuario(
                  nombre: nombreCtrl.text,
                  telefono: telefonoCtrl.text,
                  correo: correoCtrl.text,
                  direccionFiscal: direccionCtrl.text,
                );
                widget.onGuardar(actualizado);
                Navigator.pop(context);
              },
              child: Text('Guardar Cambios'),
            )
          ],
        ),
      ),
    );
  }
}