import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../models/sesion_estudio.dart';
import '../services/sesion_service.dart';

class CrearSesionScreen extends StatefulWidget {
  const CrearSesionScreen({super.key});

  @override
  State<CrearSesionScreen> createState() => _CrearSesionScreenState();
}

class _CrearSesionScreenState extends State<CrearSesionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _materiaController = TextEditingController();
  final _tareaController = TextEditingController();
  final _duracionController = TextEditingController();

  final _sesionService = SesionService();
  bool _guardando = false;

  @override
  void dispose() {
    _materiaController.dispose();
    _tareaController.dispose();
    _duracionController.dispose();
    super.dispose();
  }

  Future<void> _guardarSesion() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _guardando = true);

    try {
      final nuevaSesion = SesionEstudio(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        materia: _materiaController.text.trim(),
        tarea: _tareaController.text.trim(),
        duracionMinutos: int.parse(_duracionController.text.trim()),
      );

      await _sesionService.crear(nuevaSesion);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('¡Tarea agregada con éxito!'),
          backgroundColor: const Color(0xFF0D9488),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e is StateError ? e.message : 'Error al guardar'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _guardando = false);
      }
    }
  }

  final _materiaValidator = MultiValidator([
    RequiredValidator(errorText: 'Escribe la materia.'),
    MinLengthValidator(3, errorText: 'Al menos 3 caracteres.'),
  ]);

  final _tareaValidator = MultiValidator([
    RequiredValidator(errorText: 'Describe la tarea que tienes que hacer.'),
    MinLengthValidator(4, errorText: 'Escribe una descripción más detallada.'),
  ]);

  String? _validarDuracion(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa el tiempo en minutos.';
    }
    final minutos = int.tryParse(value.trim());
    if (minutos == null) {
      return 'Ingresa un número válido.';
    }
    if (minutos <= 0) {
      return 'El tiempo debe ser mayor a 0 minutos.';
    }
    if (minutos > 480) {
      return 'El tiempo máximo por sesión es 480 min (8h).';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Sesión de Estudio')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Organiza tu bloque de enfoque',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Define la asignatura, el objetivo puntual y los minutos que le dedicarás.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 22),
              TextFormField(
                controller: _materiaController,
                decoration: const InputDecoration(
                  labelText: 'Materia / Asignatura',
                  hintText: 'Ej: Programación Móvil, Cálculo...',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
                validator: _materiaValidator.call,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tareaController,
                decoration: const InputDecoration(
                  labelText: '¿Qué tienes que hacer? (Tarea)',
                  hintText: 'Ej: Completar formulario y validaciones',
                  prefixIcon: Icon(Icons.edit_note_rounded),
                ),
                validator: _tareaValidator.call,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _duracionController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad de tiempo (minutos)',
                  hintText: 'Ej: 45',
                  prefixIcon: Icon(Icons.timer_outlined),
                ),
                validator: _validarDuracion,
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _guardando ? null : _guardarSesion,
                  child: _guardando
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text('Guardar en mi Plan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
