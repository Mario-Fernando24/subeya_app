import 'package:flutter/material.dart';

class DefaultIconBack extends StatefulWidget {

  Color color;
  EdgeInsetsGeometry? margin;

   DefaultIconBack({
    this.color = Colors.white,
    this.margin,
    super.key
  });

  @override
  State<DefaultIconBack> createState() => _DefaultIconBackState();
}

class _DefaultIconBackState extends State<DefaultIconBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: widget.margin,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,size: 35, color: widget.color,
          ),
     )
    );
  }
}