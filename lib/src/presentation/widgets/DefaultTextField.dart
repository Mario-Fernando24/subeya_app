import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {


  String text;
  String? initialValue;
  Function(String text) onChanged;
  IconData icon;
  EdgeInsetsGeometry margin;
  String? Function(String?)? validate;
  Color? backgrooundColor;

  DefaultTextField({
    required this.text,
    required this.onChanged,
    required this.icon,
    this.margin = const EdgeInsets.only(top: 20, right: 16, left: 16),
    this.validate,
    this.backgrooundColor = Colors.white,
    this.initialValue,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: margin,
      decoration: BoxDecoration(
        color: backgrooundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: TextFormField(
        onChanged: (texto){
          onChanged(texto);
        },
        validator: validate,
        initialValue: initialValue,
        decoration: InputDecoration(
          label: Text(text),
          border: InputBorder.none,
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
