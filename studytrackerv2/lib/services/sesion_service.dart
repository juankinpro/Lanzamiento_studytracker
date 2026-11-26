import 'dart:async';
import '../models/sesion_estudio.dart';

class SesionService {
  static final List<SesionEstudio> _sesiones = [
    SesionEstudio(
      id: '1',
      materia: 'Programación Móvil',
      tarea: 'Estudiar widgets de Flutter',
      duracionMinutos: 45,
    ),
  ];

  Future<List<SesionEstudio>> listar() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List<SesionEstudio>.unmodifiable(_sesiones);
  }

  Future<SesionEstudio> crear(SesionEstudio sesion) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final existeDuplicado = _sesiones.any(
      (s) =>
          s.materia.toLowerCase() == sesion.materia.toLowerCase() &&
          s.tarea.toLowerCase() == sesion.tarea.toLowerCase(),
    );

    if (existeDuplicado) {
      throw StateError('Ya registraste esa misma tarea para esta materia.');
    }

    _sesiones.insert(0, sesion);
    return sesion;
  }

  Future<void> eliminar(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _sesiones.removeWhere((s) => s.id == id);
  }
}
