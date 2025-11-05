import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_roles/RolesBloc.dart';
import 'dart:math';

import 'package:subeya/src/presentation/bloc/bloc_roles/RolesState.dart';

// -----------------------------------------------------------
// 1. CLASES AUXILIARES PARA EL EFECTO DE LLUVIA
// -----------------------------------------------------------

// Generador de números aleatorios
final _random = Random();

class RainDrop {
  double x;
  double y;
  double speed;
  double length;

  RainDrop(double screenWidth, double screenHeight)
    : x = _random.nextDouble() * screenWidth,
      y = _random.nextDouble() * screenHeight,
      // Velocidad aleatoria para un efecto más natural
      speed = 5 + _random.nextDouble() * 10,
      // Longitud aleatoria
      length = 10 + _random.nextDouble() * 10;

  void fall(double screenHeight) {
    // Mueve la gota hacia abajo y un poco hacia la derecha para simular viento
    y += speed;
    x += 1; // Leve movimiento horizontal

    // Reinicia la gota cuando sale de la pantalla
    if (y > screenHeight) {
      y = 0;
      x = _random.nextDouble() * 1000;
      speed = 5 + _random.nextDouble() * 10;
    }
  }
}

class RainPainter extends CustomPainter {
  final List<RainDrop> drops;

  RainPainter(this.drops);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 1, 48, 67)
          .withOpacity(0.5) // Color claro y semitransparente
      ..strokeWidth = 0.8
      ..strokeCap = StrokeCap.round;

    for (var drop in drops) {
      // Dibuja la línea de la gota con un ligero ángulo
      canvas.drawLine(
        Offset(drop.x, drop.y),
        Offset(drop.x + 3, drop.y + drop.length),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// -----------------------------------------------------------
// 2. WIDGET PRINCIPAL MODIFICADO
// -----------------------------------------------------------

// Nota: Debes reemplazar 'subeya/src/presentation/bloc/bloc_roles/RolesBloc.dart'
// y 'subeya/src/presentation/bloc/bloc_roles/RolesState.dart' con tus rutas reales.

class Rolesitems extends StatefulWidget {
  @override
  _RolesitemsState createState() => _RolesitemsState();
}

class _RolesitemsState extends State<Rolesitems> with TickerProviderStateMixin {
  late AnimationController _controller;
  List<RainDrop> _rainDrops = [];
  final int _numberOfDrops = 300; // Cantidad de gotas de lluvia

  @override
  void initState() {
    super.initState();

    // Inicializa el controlador de animación para repintar
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    // Escucha los ticks para actualizar la posición de las gotas
    _controller.addListener(() {
      setState(() {
        if (_rainDrops.isNotEmpty) {
          final screenHeight = MediaQuery.of(context).size.height;
          for (var drop in _rainDrops) {
            drop.fall(screenHeight);
          }
        }
      });
    });

    // Inicializa las gotas después del primer renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initRainDrops();
    });
  }

  void _initRainDrops() {
    // Es importante verificar si el widget está montado antes de usar BuildContext.
    if (!mounted) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    _rainDrops = List.generate(
      _numberOfDrops,
      (_) => RainDrop(screenWidth, screenHeight),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Limpiar el controlador al salir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Suponiendo que RolesBloc y RolesState están definidos y disponibles
    return Scaffold(
      body: BlocBuilder<RolesBloc, RolesState>(
        builder: (context, state) {
          final roles = (state.roles != null) ? state.roles : [];

          return Stack(
            children: [
              // 1. Fondo de la ciudad
              Image.asset(
                'assets/img/city_background.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),

              // 2. Overlay de Oscuridad/Noche y Humedad
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6), // Oscurece
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),

              // 3. ✨ WIDGET DE LLUVIA (CustomPaint Animado) ✨
              // Dibuja las gotas de lluvia sobre el fondo oscuro
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: RainPainter(_rainDrops),
                  );
                },
              ),

              // 4. Contenido de Roles
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  children: roles!
                      .map<Widget>(
                        (role) => Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: InkWell(
                            // Mantenemos InkWell para el efecto de tap
                            onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              role.route ?? '/',
                              (route) => false,
                            ),
                            borderRadius: BorderRadius.circular(
                              15,
                            ), // Bordes redondeados para el InkWell
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                // Fondo completamente transparente
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular( 15), // Bordes redondeados
                                border: Border.all(
                                  color: Colors.white, // Color del borde blanco
                                  width: 1, // Ancho del borde
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: FadeInImage(
                                      placeholder: AssetImage(
                                        'assets/img/no-image.png',
                                      ),
                                      image: NetworkImage(role.image ?? ''),
                                      fit: BoxFit.contain,
                                      fadeInDuration: Duration(
                                        milliseconds: 500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    role.name ?? '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black.withOpacity(0.7),
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
