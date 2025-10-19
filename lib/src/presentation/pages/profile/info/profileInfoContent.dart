import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_profile_info/profileInfoEvent.dart';

class ProfileInfoContent extends StatefulWidget {
  
  User? user;

  ProfileInfoContent(this.user);

  @override
  State<ProfileInfoContent> createState() => _ProfileInfoContentState();
}

class _ProfileInfoContentState extends State<ProfileInfoContent> {

  @override
  void initState() {
    // TODO: implement initState
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    context.read<ProfileInfoBloc>().add(GetUserInfo());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _headerProfile(),
            Spacer(),
            _actionProfile('Editar Perfil', Icons.edit, () {
              Navigator.pushNamed(context, 'profile/update', arguments: widget.user);
            }),
            _actionProfile('Cerrar sesion', Icons.power_settings_new, () {
              print('Cerrar sesion');
            }),

          ],
        ),
        _cardUserInfo()
      ],
    );
  }

  Widget _cardUserInfo(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      margin: EdgeInsets.only(left: 20, right: 20, top: 100),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Column(
          children: [
            Container(
              width: 115,
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipOval(
                 child: FadeInImage.assetNetwork(
                    image: widget.user?.image ?? '',
                    placeholder: 'assets/img/user_image.png',
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 1)
                  ),  
                ),
                ),
            ),
            Text('${widget.user?.name ?? ''} ${widget.user?.lastname ?? ''}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
// Text(
//   jsonEncode(widget.user?.toJson() ?? {}),
//   style: TextStyle(
//     fontWeight: FontWeight.bold,
//     fontSize: 16.0,
//     color: Colors.grey[600],
//   ),
// ),        
    Text(widget.user?.email ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.grey[600]),),

    Text(widget.user?.phone ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.grey[600]),),

          ],
        ),
      ),
    );
  }

  Widget _headerProfile() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 40),
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 12, 38, 145),
            Color.fromARGB(255, 34, 156, 249),
          ],
        ),
      ),
      child: Text(
        'Perfil del usuario',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _actionProfile(String option, IconData icon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 35, top: 5.0),
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
}
