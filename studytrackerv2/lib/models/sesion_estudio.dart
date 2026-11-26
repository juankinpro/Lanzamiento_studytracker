class SesionEstudio {
  final String id;
  final String materia;
  final String tarea; //Tarea que uno escribe
  final int duracionMinutos; // el tiempo que uno le da

  SesionEstudio({
    required this.id,
    required this.materia,
    required this.tarea,
    required this.duracionMinutos,
  });
}
