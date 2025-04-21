import 'package:flutter/material.dart';
import '../models/cliente.dart';
import 'cliente_detalle_screen.dart';

class ClientesScreen extends StatelessWidget {
  final List<Cliente> clientes = [
    Cliente(
      id: '1',
      nombre: 'Juan Pérez',
      telefono: '600000000',
      lugarTrabajo: 'Casa Verde',
      direccion: 'Calle 123, Madrid',
      precios: {'Pisos': 12.0, 'Paredes': 10.0},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes (€3.190)'),
        actions: [
          IconButton(
            icon: Icon(Icons.archive),
            onPressed: () {
              // Navegar a pantalla de archivados
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (ctx, i) {
          final cliente = clientes[i];
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(cliente.nombre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Obra: ${cliente.lugarTrabajo}'),
                GestureDetector(
                  onTap: () {
                    // Abrir Google Maps
                  },
                  child: Text(
                    cliente.direccion,
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ),
              ],
            ),
            trailing: Text('Pendiente: €1200'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ClienteDetalleScreen(cliente: cliente),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Agregar nuevo cliente
        },
      ),
    );
  }
}
