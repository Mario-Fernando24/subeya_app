import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class GoogleAutoComplete extends StatefulWidget {

  TextEditingController controller = TextEditingController();
  String hintText;
  Function(Prediction prediction) onPlaceSelected;

   GoogleAutoComplete(
    this.controller,
    this.hintText,
    this.onPlaceSelected,
     {super.key});

  @override
  State<GoogleAutoComplete> createState() => _GoogleAutoCompleteState();
}

class _GoogleAutoCompleteState extends State<GoogleAutoComplete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: widget.controller,
         boxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
        ),
        googleAPIKey:"AIzaSyBNdhgYWo-JBxpcLQk1m5kutUa_LLPgGAc",
        inputDecoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black12),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 400,
        countries: ["co"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: widget.onPlaceSelected,

        itemClick: (Prediction prediction) {
          widget.controller.text = prediction.description ?? "";
          widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: Divider(),
        containerHorizontalPadding: 10,


        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 7,
                ),
                Expanded(child: Text("${prediction.description ?? ""}"))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }
}