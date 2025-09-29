import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Sharefpref {

    //guardar datos en shared preferences
    Future<void> save(String key, dynamic value) async {
       final prefs = await SharedPreferences.getInstance();
       await prefs.setString(key, json.encode(value));
    }

      //leer datos en shared preferences
    Future<dynamic> read(String key) async {
      final prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(key);
      if(data != null){
        return json.decode(data);
      }
      return null; 
    }

    //eliminar datos en shared preferences
    Future<bool> remove(String key) async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(key);
    }

}