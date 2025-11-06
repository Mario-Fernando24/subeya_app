import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/main.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_drivers_home/DriversHomeBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_drivers/bloc_drivers_home/DriversHomeState.dart';
import 'package:subeya/src/presentation/pages/driver/mapViaje/mapLocationDriversPage.dart';
import 'package:subeya/src/presentation/pages/profile/info/profileInfoPage.dart';
import 'package:subeya/src/presentation/pages/roles/rolesItems.dart';
import 'package:subeya/src/presentation/themes/app_colors.dart';
import 'package:subeya/src/presentation/themes/app_text_styles.dart';

import '../../../bloc/bloc_drivers/bloc_drivers_home/DriversHomeEvent.dart';

class DriveHomePage extends StatefulWidget {
  const DriveHomePage({super.key});

  @override
  State<DriveHomePage> createState() => _DriveHomePageState();
}

class _DriveHomePageState extends State<DriveHomePage> {
  List<Widget> pageList = [
    MapLocationsDriversPage(),
    ProfileInfoPage(),
    Rolesitems()
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conductor Subeya')),
      body: BlocBuilder<DriversHomeBloc, DriversHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocBuilder<DriversHomeBloc, DriversHomeState>(
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
                    'Menu Conductor',
                    style: AppTextStyles.titleWhite,
                  ),

                  
                ),
                 ListTile(
                  leading: Icon(Icons.person, color: AppColors.black),
                  title: Text('Mapa de localizacón', style: AppTextStyles.subtitle,),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context.read<DriversHomeBloc>().add(
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
                    context.read<DriversHomeBloc>().add(
                      ChangeDrawerIndex(index: 1),
                    );
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                 ListTile(
                  leading: Icon(Icons.person, color: AppColors.black),
                  title: Text('Roles de usuario',style: AppTextStyles.subtitle,),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    context.read<DriversHomeBloc>().add(
                      ChangeDrawerIndex(index: 2),
                    );
                    Navigator.pop(context); // Close the drawer
                  },
                ),
               
                 ListTile(
                  leading: Icon(Icons.logout, color: AppColors.black),
                  title: Text('Salir',style: AppTextStyles.subtitle,),
                  onTap: () {
                    context.read<DriversHomeBloc>().add(Logout());
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
