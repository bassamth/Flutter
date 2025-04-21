import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../models/trabajo.dart';
import '../models/pago.dart';

class ClienteDetalleScreen extends StatefulWidget {
  final Cliente cliente;

  ClienteDetalleScreen({required this.cliente});

  @override
  _ClienteDetalleScreenState createState() => _ClienteDetalleScreenState();
}

class _ClienteDetalleScreenState extends State<ClienteDetalleScreen> {
  List<Trabajo> trabajos = [];
  List<Pago> pagos = [];

  @override
  Widget build(BuildContext context) {
    double total = trabajos.fold(0, (sum, t) => t.incluirEnResumen ? sum + t.metros * t.precio : sum);
    double pagado = pagos.fold(0, (sum, p) => sum + p.monto);
    double pendiente = total - pagado;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cliente.nombre),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              // Generar PDF
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total: €${total.toStringAsFixed(2)}'),
                Text('Pagado: €${pagado.toStringAsFixed(2)}'),
                Text('Pendiente: €${pendiente.toStringAsFixed(2)}'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: trabajos.length,
              itemBuilder: (ctx, i) {
                final trabajo = trabajos[i];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text('${trabajo.tipo} - ${trabajo.metros} m²'),
                    subtitle: Text('${trabajo.fecha.day}/${trabajo.fecha.month}/${trabajo.fecha.year}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.teal.shade100,
                          child: Text(
                            '€${trabajo.precio}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    onLongPress: () {
                      // Mostrar opciones editar/eliminar/archivar
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Agregar trabajo o pago
        },
      ),
    );
  }
}