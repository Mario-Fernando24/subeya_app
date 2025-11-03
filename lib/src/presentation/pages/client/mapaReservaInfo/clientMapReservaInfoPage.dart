import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente_info/ClientMapaInfoBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente_info/ClientMapaInfoEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente_info/ClientMapaInfoState.dart';
import 'package:subeya/src/presentation/widgets/DefaultButton.dart';
import 'package:subeya/src/presentation/widgets/DefaultIconBack.dart';
import 'package:subeya/src/presentation/widgets/DefaultTextField.dart';

class ClientMapReservaInfopage extends StatefulWidget {
  const ClientMapReservaInfopage({super.key});

  @override
  State<ClientMapReservaInfopage> createState() => _ClientMapReservaInfopageState();
}

class _ClientMapReservaInfopageState extends State<ClientMapReservaInfopage> {

    LatLng? lugarRecogida;
    LatLng? lugarDestino;
    String? lugarRecogidaText;
    String? lugarDestinoText;
    
    @override
  void initState() {
    // esperar a que se renderice la pantalla
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapaInfoBloc>().add(ClientMapInicializarEventoInfo(
        lugarInicialInfo: lugarRecogida,
        lugarDestinoInfo: lugarDestino,
        descripcionLugarInicialInfo: lugarRecogidaText,
        descripcionLugarDestinoInfo: lugarDestinoText
        ));
        context.read<ClientMapaInfoBloc>().add(AddPolylinesToMapEvent());
         // 👇 Evento que centra la cámara en la ubicación inicial
        context.read<ClientMapaInfoBloc>().add(ChangeMapCameraPosition(
          lat: lugarRecogida!.latitude,
          lng: lugarRecogida!.longitude,
        ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> reservaData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

     lugarRecogida = reservaData['lugarRecogidaLatLng'];
     lugarDestino = reservaData['lugarDestinoLatLng'];
     lugarRecogidaText = reservaData['lugarRecogidaText'];
     lugarDestinoText = reservaData['lugarDestinoText'];

    return Scaffold(
      body: BlocBuilder<ClientMapaInfoBloc, ClientMapaInfoState>(
        builder: (context, state) {
          return Stack(
            children: [
            _googleMap(state),
            Align(
              alignment: Alignment.bottomCenter,
              child: _cardReservaInfo()
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 10),
                child: DefaultIconBack()
                )
            ]
          );
        },
      ),
    );
  }

  Widget _cardReservaInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero, // 👈 elimina espacio lateral y vertical
            leading: const Icon(Icons.location_on),
            title: const Text('Recoger en:', style: TextStyle(fontSize: 14.0)),
            subtitle: const Text('Calle 143 #45-67', style: TextStyle(fontSize: 12.0)),
            dense: true, // 👈 reduce la altura total del ListTile
            visualDensity: VisualDensity(vertical: -4), // 👈 reduce aún más la separación
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.my_location),
            title: const Text('Dejar en:', style: TextStyle(fontSize: 14.0)),
            subtitle: const Text('Calle 32 #45-67', style: TextStyle(fontSize: 12.0)),
            dense: true,
            visualDensity: VisualDensity(vertical: -4),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.timer),
            title: const Text('Tiempo y distancia aproximada:', style: TextStyle(fontSize: 14.0)),
            subtitle: const Text('0 km y 0 min', style: TextStyle(fontSize: 12.0)),
            dense: true,
            visualDensity: VisualDensity(vertical: -4),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.attach_money),
            title: const Text('Precios recomendados', style: TextStyle(fontSize: 14.0)),
            subtitle: const Text('\$2.000', style: TextStyle(fontSize: 12.0)),
            dense: true,
            visualDensity: VisualDensity(vertical: -4),
          ),
          const SizedBox(height: 6), // 👈 pequeño respiro antes del textfield
          DefaultTextField(
            margin: const EdgeInsets.only(bottom: 10),
            text: 'Ofrece tu tarifa',
            onChanged: (text) {},
            icon: Icons.attach_money,
            keyboardType: TextInputType.number,
          ),
           _actionSearchBuscarConductor('Buscar conductor', Icons.search, () {
            // Acción al presionar el botón
          }),
        ],
      ),
    );
  }

  Widget _actionSearchBuscarConductor(String option, IconData icon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 0.0, right: 20, top: 5.0),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 14, 29, 166),
                  Color.fromARGB(255, 30, 112, 227),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(
            option,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
         
        ),
      ),
    );
  }

  Widget _googleMap(ClientMapaInfoState state) {
    return Container(
      height: MediaQuery.of(context).size.height*0.52,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition ??
            CameraPosition(
              target: LatLng(8.735667, -75.867218),
              zoom: 14,
            ),
        myLocationEnabled: true,
        //markers: Set<Marker>.of(state.markers.values),
        polylines: Set<Polyline>.of(state.polylines.values),
        onMapCreated: (GoogleMapController controller) {
          if (!state.controller!.isCompleted) {
            state.controller!.complete(controller);
            controller.setMapStyle(
              '[ { "elementType": "geometry", "stylers": [ { "color": "#212121" } ] }, { "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#212121" } ] }, { "featureType": "administrative", "elementType": "geometry", "stylers": [ { "color": "#757575" } ] }, { "featureType": "administrative.country", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "administrative.land_parcel", "stylers": [ { "visibility": "off" } ] }, { "featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [ { "color": "#bdbdbd" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#181818" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "poi.park", "elementType": "labels.text.stroke", "stylers": [ { "color": "#1b1b1b" } ] }, { "featureType": "road", "elementType": "geometry.fill", "stylers": [ { "color": "#2c2c2c" } ] }, { "featureType": "road", "elementType": "labels.text.fill", "stylers": [ { "color": "#8a8a8a" } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#373737" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#3c3c3c" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [ { "color": "#4e4e4e" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "transit", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#3d3d3d" } ] } ]',
            );
          }
        }, 
      ),
    );
  }
}
