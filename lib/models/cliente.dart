class Cliente {
  String id;
  String nombre;
  String telefono;
  String lugarTrabajo;
  String direccion;
  String? dni;
  String? imagenUrl;
  Map<String, double> precios;

  Cliente({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.lugarTrabajo,
    required this.direccion,
    this.dni,
    this.imagenUrl,
    required this.precios,
  });
}