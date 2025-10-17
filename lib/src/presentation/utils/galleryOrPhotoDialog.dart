import 'package:flutter/material.dart';

GalleryOrPhotsDialog(BuildContext context, Function() onTapGallery, Function() onTapPhoto) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecciona una opción'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.photo_library, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Galería'),
                    ],
                  ),
                  onTap: () {
                    onTapGallery();
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Cámara'),
                    ],
                  ),
                  onTap: () {
                    onTapPhoto();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}
  