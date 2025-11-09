import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_locations_drivers/DriversLocationsMapaBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_locations_drivers/DriversLocationsMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_locations_drivers/DriversLocationsMapaState.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaState.dart';
import 'package:subeya/src/presentation/widgets/DefaultButton.dart';

class MapLocationsDriversPage extends StatefulWidget {
  const MapLocationsDriversPage({super.key});

  @override
  State<MapLocationsDriversPage> createState() => _MapLocationsDriversPageState();
}

class _MapLocationsDriversPageState extends State<MapLocationsDriversPage> {
 // Posición inicial del mapa (Googleplex)
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(8.735667, -75.867218), // Coordenadas
    zoom: 14.4746, // Nivel de zoom
  );
  TextEditingController lugarRecogida = TextEditingController();
  TextEditingController lugarDestino = TextEditingController();

  @override
  void initState() {
    // esperar a que se renderice la pantalla
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriversLocationsMapaBloc>().add(DriversMapInicializarEvento());
      context.read<DriversLocationsMapaBloc>().add(FindPositionDrivers());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // la condicion mounted es para evitar errores si la página ya no está en pantalla
      if(mounted){
        context.read<DriversLocationsMapaBloc>().add(StopLocationsPositionStreamDriversEvent());
      }
    }); 
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DriversLocationsMapaBloc, DriversLocationsMapaState>(
        builder: (context, state) {
          return Stack(
            children: [
              _googleMap(state),
              
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: DefaultButton(
                  margin: EdgeInsets.only(top: 20),
                  onPressed: ()=> context.read<DriversLocationsMapaBloc>().add(StopLocationsPositionStreamDriversEvent()),
                  text: 'DETENER LOCALIZACIÓN',
                  ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _googleMap(DriversLocationsMapaState state) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: state.cameraPosition ?? _kGooglePlex,
      myLocationEnabled: true,
      onCameraMove: (CameraPosition cameraPosition) {
        // actualizar la posición de la cámara en el estado del BLoC
        context.read<DriversLocationsMapaBloc>().add(
          CameraPositionChangedDriversEvent(cameraPosition: cameraPosition),
        );
      },
   
      myLocationButtonEnabled: true,
      markers: Set<Marker>.of(state.markers.values),
      onMapCreated: (GoogleMapController controller) {
        if (!state.controller!.isCompleted) {
          state.controller!.complete(controller);
          controller.setMapStyle(
            '[ { "elementType": "geometry", "stylers": [ { "color": "#212121" } ] }, { "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#212121" } ] }, { "featureType": "administrative", "elementType": "geometry", "stylers": [ { "color": "#757575" } ] }, { "featureType": "administrative.country", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "administrative.land_parcel", "stylers": [ { "visibility": "off" } ] }, { "featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [ { "color": "#bdbdbd" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#181818" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "poi.park", "elementType": "labels.text.stroke", "stylers": [ { "color": "#1b1b1b" } ] }, { "featureType": "road", "elementType": "geometry.fill", "stylers": [ { "color": "#2c2c2c" } ] }, { "featureType": "road", "elementType": "labels.text.fill", "stylers": [ { "color": "#8a8a8a" } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#373737" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#3c3c3c" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [ { "color": "#4e4e4e" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "transit", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#3d3d3d" } ] } ]',
          );
        }
      },
    );
  }




}
