import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:subeya/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:subeya/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:subeya/src/presentation/pages/profile/info/profileInfoPage.dart';

class Clienthomepage extends StatefulWidget {
  const Clienthomepage({super.key});

  @override
  State<Clienthomepage> createState() => _ClienthomepageState();
}

class _ClienthomepageState extends State<Clienthomepage> {
  List<Widget> pageList = [ProfileInfoPage()];

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
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Perfil de usuario'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context.read<ClientHomeBloc>().add(
                      ChangeDrawerIndex(index: 0),
                    );
                    Navigator.pop(context); // Close the drawer
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
