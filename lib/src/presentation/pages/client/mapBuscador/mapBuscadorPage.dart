import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaState.dart';

class ClientMapBuscador extends StatefulWidget {
  const ClientMapBuscador({super.key});

  @override
  State<ClientMapBuscador> createState() => _ClientMapBuscadorState();
}

class _ClientMapBuscadorState extends State<ClientMapBuscador> {
  // Controlador del mapa (permite mover la cámara, añadir marcadores, etc.)
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Posición inicial del mapa (Googleplex)
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(8.881064, -75.800981), // Coordenadas
    zoom: 14.4746, // Nivel de zoom
  );

  // Segunda posición a donde se moverá la cámara
  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799, // Orientación (rotación)
    target: LatLng(8.881064, -75.800981), // Coordenadas
    tilt: 59.440717697143555, // Inclinación
    zoom: 19.151926040649414, // Zoom más cercano
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientMapaBloc, ClientMapaState>(
        builder: (context, state) {
          return GoogleMap(
            mapType: MapType.normal, // Tipo de mapa: satélite + etiquetas
            initialCameraPosition: _kGooglePlex, // Posición inicial
            onMapCreated: (GoogleMapController controller) {
              // Se completa el controlador cuando el mapa se carga
              _controller.complete(controller);
            },
            myLocationEnabled:
                false, // Mostrar ubicación del usuario (requiere permisos)
            zoomControlsEnabled: true, // Mostrar botones de zoom
            compassEnabled: true, // Mostrar brújula
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake, // Acción del botón
        label: const Text(''),
        icon: const Icon(Icons.gps_fixed_sharp),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }

  // Método para mover la cámara con animación a otra posición
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
