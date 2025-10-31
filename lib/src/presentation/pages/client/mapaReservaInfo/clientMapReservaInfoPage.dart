import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientMapReservaInfopage extends StatefulWidget {


  const ClientMapReservaInfopage({super.key});

  @override
  State<ClientMapReservaInfopage> createState() => _ClientMapReservaInfopageState();
}

class _ClientMapReservaInfopageState extends State<ClientMapReservaInfopage> {
  @override
  Widget build(BuildContext context) {
    
    Map<String, dynamic> reservaData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    LatLng lugarRecogida = reservaData['lugarRecogidaLatLng'];
    LatLng lugarDestino = reservaData['lugarDestinoLatLng'];  
    String lugarRecogidaText = reservaData['lugarRecogidaText'];
    String lugarDestinoText = reservaData['lugarDestinoText'];


    return Scaffold(
      appBar: AppBar(
        title: Text('Información de la Reserva'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Detalles de la reserva aparecerán aquí.'),
            Text('Lugar de Recogida: $lugarRecogidaText (${lugarRecogida.latitude}, ${lugarRecogida.longitude})'),
            Text('Lugar de Destino: $lugarDestinoText (${lugarDestino.latitude}, ${lugarDestino.longitude})'),
          ],
        ),
      ),
      );
  }
}