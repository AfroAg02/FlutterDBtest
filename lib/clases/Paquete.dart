class PaqueteDTO {
  String hbl;
  double peso;
  Status status;
  DateTime? date;
  String description;

  PaqueteDTO({
    required this.hbl,
    required this.peso,
    required this.status,
    this.date,
    required this.description,
  });
}
enum Status {
  rechazado,
  aceptado,
  pendiente,
}