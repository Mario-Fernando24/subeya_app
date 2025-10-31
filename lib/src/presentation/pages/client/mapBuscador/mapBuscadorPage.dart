import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaState.dart';
import 'package:subeya/src/presentation/widgets/DefaultButton.dart';
import 'package:subeya/src/presentation/widgets/GoogleAutoComplete.dart';

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
  TextEditingController lugarRecogida = TextEditingController();
  TextEditingController lugarDestino = TextEditingController();

  @override
  void initState() {
    // esperar a que se renderice la pantalla
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapaBloc>().add(ClientMapInicializarEvento());
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
          return Stack(
            children: [
              _googleMap(state),
              Container(
                height: 130,
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: _googlePlaceAutocomplete(),
              ),
              _iconMyLocation(),
              
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: DefaultButton(
                  onPressed: ()=> Navigator.pushNamed(context, 'client/mapaReservado'),
                  text: 'Regresar viaje'
                  ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _googleMap(ClientMapaState state) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: state.cameraPosition ?? _kGooglePlex,
      myLocationEnabled: true,
      onCameraMove: (CameraPosition cameraPosition) {
        context.read<ClientMapaBloc>().add(
          CameraPositionChangedEvent(cameraPosition: cameraPosition),
        );
      },
      onCameraIdle: () async {
        // Aquí puedes manejar eventos cuando la cámara se detiene
        context.read<ClientMapaBloc>().add(OnCameraIdleEvent());
        lugarRecogida.text = state.placemarkData?.address ?? '';
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

  Widget _googlePlaceAutocomplete() {
    return Card(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 4.0),
          GoogleAutoComplete(lugarRecogida, 'Recoger en', (
            Prediction prediction,
          ) {
            if (prediction != null) {
              print(
                ' Prediction selected: ${prediction.description}, lat: ${prediction.lat}, lng: ${prediction.lng}',
              );
              context.read<ClientMapaBloc>().add(
                ChangeMapCameraPosition(
                  lat: double.parse(prediction.lat!),
                  lng: double.parse(prediction.lng!),
                ),
              );

              context.read<ClientMapaBloc>().add(
                OnAutoCompleteLugarRecogida(
                  lat: double.parse(prediction.lat!),
                  lng: double.parse(prediction.lng!),
                  description: prediction.description!,
                ),
              );
            }
          }),
          SizedBox(height: 4.0),
          GoogleAutoComplete(lugarDestino, 'Dejar en', (Prediction prediction) {
            context.read<ClientMapaBloc>().add(
              OnAutoCompleteLugarDestino(
                lat: double.parse(prediction.lat!),
                lng: double.parse(prediction.lng!),
                description: prediction.description!,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _iconMyLocation() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20),
      child: Image.asset('assets/img/location_blue.png', width: 65, height: 65),
    );
  }
}
