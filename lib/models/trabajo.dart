class Trabajo {
  String tipo;
  double metros;
  double precio;
  DateTime fecha;
  bool incluirEnResumen;

  Trabajo({
    required this.tipo,
    required this.metros,
    required this.precio,
    required this.fecha,
    this.incluirEnResumen = true,
  });
}