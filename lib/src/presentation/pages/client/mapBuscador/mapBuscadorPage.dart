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
             controller.setMapStyle('[ { "elementType": "geometry", "stylers": [ { "color": "#212121" } ] }, { "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#212121" } ] }, { "featureType": "administrative", "elementType": "geometry", "stylers": [ { "color": "#757575" } ] }, { "featureType": "administrative.country", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "administrative.land_parcel", "stylers": [ { "visibility": "off" } ] }, { "featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [ { "color": "#bdbdbd" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#181818" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "poi.park", "elementType": "labels.text.stroke", "stylers": [ { "color": "#1b1b1b" } ] }, { "featureType": "road", "elementType": "geometry.fill", "stylers": [ { "color": "#2c2c2c" } ] }, { "featureType": "road", "elementType": "labels.text.fill", "stylers": [ { "color": "#8a8a8a" } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#373737" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#3c3c3c" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [ { "color": "#4e4e4e" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "transit", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#3d3d3d" } ] } ]');
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
