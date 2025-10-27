import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_mapa_cliente/ClientMapaState.dart';
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
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set<Marker>.of(state.markers.values),
                onMapCreated: (GoogleMapController controller) {
                  if (!state.controller!.isCompleted) {
                    state.controller!.complete(controller);
                  }
                },
              ),
              Container(
                height: 130,
                margin: EdgeInsets.only(left: 20 ,right: 20, top: 10),
                child: Card(
                  surfaceTintColor: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 4.0),
                      GoogleAutoComplete(
                        lugarRecogida, 
                        'Recoger en', (
                        Prediction prediction) {
                        print(
                          'latitud: ${prediction.lat}, longitud: ${prediction.lng}',
                        );
                        print(
                          "Lugar de recogida seleccionado: ${prediction.description}",
                        );
                      }),
                      SizedBox(height: 4.0),
                      GoogleAutoComplete(
                        lugarDestino, 
                        'Dejar en', (
                        Prediction prediction,
                      ) {
                        print(
                          'latitud: ${prediction.lat}, longitud: ${prediction.lng}',
                        );
                        print(
                          "Lugar de recogida seleccionado: ${prediction.description}",
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
