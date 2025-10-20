import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/main.dart';
import 'package:subeya/src/presentation/bloc/bloc_client_home/ClientHomeBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_client_home/ClientHomeEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_client_home/ClientHomeState.dart';
import 'package:subeya/src/presentation/pages/client/mapBuscador/mapBuscadorPage.dart';
import 'package:subeya/src/presentation/pages/profile/info/profileInfoPage.dart';
import 'package:subeya/src/presentation/themes/app_colors.dart';
import 'package:subeya/src/presentation/themes/app_text_styles.dart';

class Clienthomepage extends StatefulWidget {
  const Clienthomepage({super.key});

  @override
  State<Clienthomepage> createState() => _ClienthomepageState();
}

class _ClienthomepageState extends State<Clienthomepage> {
  List<Widget> pageList = [
    ClientMapBuscador(),
    ProfileInfoPage()
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Principal')),
      body: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                     gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 14, 29, 166),
                  Color.fromARGB(255, 30, 112, 227),
                ],
              ),
                  ),
                  child: Text(
                    'Menu Cliente',
                    style: AppTextStyles.titleWhite,
                  ),

                  
                ),
                 ListTile(
                  leading: Icon(Icons.person, color: AppColors.black),
                  title: Text('Mapa de busqueda', style: AppTextStyles.subtitle,),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context.read<ClientHomeBloc>().add(
                      ChangeDrawerIndex(index: 0),
                    );
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: AppColors.black),
                  title: Text('Perfil de usuario',style: AppTextStyles.subtitle,),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context.read<ClientHomeBloc>().add(
                      ChangeDrawerIndex(index: 1),
                    );
                    Navigator.pop(context); // Close the drawer
                  },
                ),
               
                 ListTile(
                  leading: Icon(Icons.logout, color: AppColors.black),
                  title: Text('Salir',style: AppTextStyles.subtitle,),
                  onTap: () {
                    context.read<ClientHomeBloc>().add(Logout());
                    Navigator.pushAndRemoveUntil(context, 
                    MaterialPageRoute(builder: (context) =>MyApp()), (route) => false);
                  },
                ),
                // Add more ListTiles for other menu options
              ],
            ),
          );
        },
      ),
    );
  }
}
