class Usuario {
  String nombre;
  String telefono;
  String correo;
  String direccionFiscal;
  String? logoUrl;

  Usuario({
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.direccionFiscal,
    this.logoUrl,
  });
}