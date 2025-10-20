import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaState.dart';

class ClientMapBuscador extends StatefulWidget {
  const ClientMapBuscador({super.key});

  @override
  State<ClientMapBuscador> createState() => _ClientMapBuscadorState();
}

class _ClientMapBuscadorState extends State<ClientMapBuscador> {

  // Posición inicial del mapa (Googleplex)
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(8.735667, -75.867218), // Coordenadas
    zoom: 14.4746, // Nivel de zoom
  );


  @override
  void initState() {
     // esperar a que se renderice la pantalla
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapaBloc>().add(FindPosition());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientMapaBloc, ClientMapaState>(
        builder: (context, state) {
          return GoogleMap(
            mapType: MapType.normal, // Tipo de mapa: satélite + etiquetas
            initialCameraPosition: _kGooglePlex, // Posición inicial
            markers: Set<Marker>.of(state.markers.values),
            onMapCreated: (GoogleMapController controller) {
              // Se completa el controlador cuando el mapa se carga
             state.controller!.complete(controller);
            },
            myLocationEnabled:
                false, // Mostrar ubicación del usuario (requiere permisos)
            zoomControlsEnabled: true, // Mostrar botones de zoom
            compassEnabled: true, // Mostrar brújula
          );
        },
      ),
     
    );
  }

}
