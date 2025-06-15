import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome',
           style: TextStyle(fontSize: 25
            )
          ),
          Text('Back...',
           style: TextStyle(fontSize: 25
            )
          ),
           Text('Log in',
           style: TextStyle(fontSize: 20
            )
          ),

          TextField(
            decoration: InputDecoration(
              label: Text('Email'),
              prefixIcon: Icon(
                Icons.email
              )
            ),
          ),

          TextField(
            decoration: InputDecoration(
              label: Text('Email'),
              prefixIcon: Icon(
                Icons.email
              )
            ),
          ),

          ElevatedButton(
            onPressed: (){}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan
            ),
            child: Text('Iniciar sesión',
              style: TextStyle(
                color: Colors.white
              )
            )
            )
        ],
      ),
    );
  }
}