# Ficha de Tienda — StudyTracker

## 1. Nombre y Categoría
- **Nombre de la aplicación:** StudyTracker
- **Categoría propuesta:** Educación / Productividad

## 2. Descripción Corta
Organiza tus materias, planifica bloques de estudio con tiempos definidos y mantén el control diario de tus tareas académicas.

## 3. Descripción Completa
**StudyTracker** está diseñada para estudiantes universitarios y personas que dividen su jornada entre el trabajo y el estudio, quienes necesitan estructurar su tiempo libre sin distracciones.

Con una interfaz limpia y directa, la aplicación permite registrar sesiones de estudio detalladas asociando cada tarea a una asignatura y asignándole una meta de tiempo en minutos. Incluye un tablero superior de resumen que contabiliza el total de tareas pendientes y la carga horaria acumulada.

**Funciones principales:**
- Acceso seguro mediante autenticación de usuario (registro e inicio de sesión con correo y contraseña).
- Registro personalizado de tareas con asignatura, descripción del objetivo y duración estimada en minutos.
- Validación inteligente de datos para evitar registros incompletos, duplicados o tiempos inválidos.
- Panel de resumen con conteo automático de tareas y minutos totales planificados.
- Eliminación inmediata de tareas completadas o descartadas.

## 4. Público Objetivo
Estudiantes de educación superior, técnicos y autodidactas (especialmente quienes trabajan y estudian simultáneamente) que requieren visualizar de forma rápida qué deben estudiar hoy y cuánto tiempo les tomará cada bloque.


## 5. Datos y Permisos
- **Datos manejados:** Correo electrónico para la autenticación de sesión; nombres de materias, descripciones de tareas y duraciones en minutos ingresados por el usuario.
- **Uso de autenticación:** Garantizar que el acceso a la herramienta esté vinculado a una cuenta de usuario verificada mediante Firebase Authentication.
- **Permisos solicitados:** Acceso a Internet (`android.permission.INTERNET`) únicamente para validar las credenciales de inicio de sesión con los servidores de Firebase. No solicita acceso a cámara, ubicación, contactos ni almacenamiento externo.

## 6. Política de Privacidad Propuesta
- **Recolección y uso:** StudyTracker recopila únicamente el correo electrónico necesario para autenticar el ingreso mediante Firebase Authentication. Los registros de tareas y tiempos de estudio se procesan localmente en la memoria de la sesión activa y no se comparten, venden ni ceden a terceros.
- **Derechos y soporte:** El usuario puede cerrar su sesión en cualquier momento desde la barra superior. Para solicitar soporte técnico o la eliminación definitiva de su cuenta de correo en Firebase, puede contactar al desarrollador a través del repositorio oficial de la aplicación.
- **Alcance actual:** Actualmente las tareas se almacenan en memoria temporal durante la ejecución; la sincronización permanente en la nube por usuario está definida para la siguiente versión.

## 7. Estado de Lanzamiento
- **Versión propuesta:** `v2.0.0-beta` (MVP funcional).
- **Funciones listas:** Autenticación y registro con Firebase (login, logout y manejo de errores), creación de sesiones con validación de dominio, prevención de duplicados, cálculo automático de tiempo total y eliminación dinámica de registros.
- **Limitaciones conocidas:** Las sesiones de estudio residen en memoria temporal (`SesionService`), por lo que se reinician al cerrar completamente la aplicación. No incluye temporizador regresivo en vivo (cronómetro).
- **Mejoras futuras:** Persistencia en base de datos en la nube (Cloud Firestore) vinculada al identificador de cada usuario y temporizador Pomodoro integrado por cada tarjeta.