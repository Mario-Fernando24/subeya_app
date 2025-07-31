import 'package:flutter/material.dart';

class DefaultTextFieldOutlined extends StatelessWidget {


  String text;
  IconData icon;
  EdgeInsetsGeometry margin;
  Function(String text) onChanged;
  String? Function(String?)? validate;


  DefaultTextFieldOutlined({
    required this.text,
    required this.icon,
    this.margin = const EdgeInsets.only(top: 20, right: 16, left: 16),
    required this.onChanged,
    this.validate

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: margin,
      decoration: BoxDecoration(
        // color: const Color.fromRGBO(255, 255, 255, 0.2),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(15),
        //   bottomRight: Radius.circular(15),
        // ),
      ),
      child: TextFormField(
        onChanged: (texto){
          
          print("******************************");
          print(texto);
          print("******************************");
          onChanged(texto);
        },
        validator: validate,
        decoration: InputDecoration(
          label: Text(text),
          //border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 35, 161, 183),
              width: 1
            )
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 34, 101, 202),
              width: 1
            )
          ),
          prefixIcon: Container(
            margin: EdgeInsets.only(top: 10),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Icon(icon),
                Container(height: 20, width: 1, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
