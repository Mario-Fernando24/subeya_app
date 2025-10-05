import 'package:flutter/material.dart';

class ProfileInfoContent extends StatefulWidget {
  const ProfileInfoContent({super.key});

  @override
  State<ProfileInfoContent> createState() => _ProfileInfoContentState();
}

class _ProfileInfoContentState extends State<ProfileInfoContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _headerProfile(),
            Spacer(),
            _actionProfile('Editar Perfil', Icons.edit),
             _actionProfile('Cerrar sesion', Icons.power_settings_new),

          ],
        ),
      ],
    );
  }

  Widget _cardUserInfo(){
    return Card(
      child: Column(
        children: [
          Container(
            width: 150,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
               child: FadeInImage.assetNetwork(
                  image: 'https://warena.co/assets/img/warena-logo1.png',
                  placeholder: 'assets/img/user_image.png',
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 1)
                ),  
              ),
              ),
          )
        ],
      ),
    );
  }

  Widget _headerProfile() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 40),
      height: MediaQuery.of(context).size.height * 0.3,
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
        'PERFIL DEL USUARIO',
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
        onTap: () {},
      ),
    );
  }
}
