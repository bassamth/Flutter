import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/cliente.dart';
import '../models/trabajo.dart';
import '../models/usuario.dart';

class PDFGenerator {
  static Future<File> generarFactura({
    required Cliente cliente,
    required List<Trabajo> trabajos,
    required Usuario emisor,
    required double ivaPorcentaje,
  }) async {
    final pdf = pw.Document();

    final subtotal = trabajos.fold(0.0, (sum, t) => sum + (t.metros * t.precio));
    final iva = subtotal * ivaPorcentaje / 100;
    final totalConIva = subtotal + iva;

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('FACTURA', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Emitido por:'),
            pw.Text(emisor.nombre),
            pw.Text(emisor.telefono),
            pw.Text(emisor.correo),
            pw.Text(emisor.direccionFiscal),
            pw.SizedBox(height: 20),
            pw.Text('Cliente:'),
            pw.Text(cliente.nombre),
            pw.Text(cliente.telefono),
            if (cliente.dni != null) pw.Text('DNI: ${cliente.dni}'),
            pw.Text(cliente.direccion),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ['Tipo', 'Metros', '€/m²', 'Total'],
              data: trabajos.map((t) => [
                t.tipo,
                t.metros.toStringAsFixed(2),
                '€${t.precio}',
                '€${(t.metros * t.precio).toStringAsFixed(2)}',
              ]).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Subtotal: €${subtotal.toStringAsFixed(2)}'),
            pw.Text('IVA (${ivaPorcentaje.toInt()}%): €${iva.toStringAsFixed(2)}'),
            pw.Text('Total con IVA: €${totalConIva.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/factura_${cliente.nombre}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}