import 'package:flutter/material.dart';
import 'package:subeya/src/domain/models/user_model.dart';
import 'package:subeya/src/presentation/widgets/DefaultIconBack.dart';
import 'package:subeya/src/presentation/widgets/DefaultTextField.dart';

class ProfileUpdateContent extends StatelessWidget {
  
  User ? user;

  ProfileUpdateContent(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _headerProfile(context),
            Spacer(),
             _actionProfile('Actualizar Usuario', Icons.check),

          ],
        ),
         
        _cardUserInfo(context),
         DefaultIconBack(
          color: Colors.white,
          margin: EdgeInsets.only(top: 50, left: 30),
        )
       
      ],
    );
  }

  Widget _cardUserInfo(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.50,
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
                    image: 'https://i.postimg.cc/5NyPJLjf/BANNER-png-3.png',
                    placeholder: 'assets/img/user_image.png',
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 1)
                  ),  
                ),
                ),
            ),
            DefaultTextField(
              text: 'Nombre',
              icon: Icons.person,
              initialValue: user?.name ?? '',
              onChanged:(text) => {},
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              validate: (value){},
              backgrooundColor: Colors.grey[200],
            ),
              DefaultTextField(
              text: 'Apellido',
              icon: Icons.person_2_outlined,
              initialValue: user?.lastname ?? '',
              onChanged:(text) => {},
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              validate: (value){},
              backgrooundColor: Colors.grey[200],
            ),
              DefaultTextField(
              text: 'Telefono',
              icon: Icons.phone,
              initialValue: user?.phone ?? '',
              onChanged:(text) => {},
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              validate: (value){},
              backgrooundColor: Colors.grey[200],
            ),
            // Text('${user?.name ?? ''} ${user?.lastname ?? ''}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
            // Text(user?.email ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.grey[600]),),
            // Text(user?.phone ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.grey[600]),),

          ],
        ),
      ),
    );
  }

  Widget _headerProfile(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 60),
      height: MediaQuery.of(context).size.height * 0.40,
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
        'Actualizar usuario',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _actionProfile(String option, IconData icon) {
    return Container(
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
        onTap: () {
          print(  'OPCION: $option');
        },
      ),
    );
  }
}
