import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 21, 152, 213),
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: Text('Login', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 27

                 ),
                ),
              ),
              SizedBox(height: 10),
              RotatedBox(
                quarterTurns: 1,
                child: Text('Registro', style: TextStyle(
                  color: Colors.white,
                   fontWeight: FontWeight.bold,
                  fontSize: 27
                 )),
              ),
            ],
          ),
         ),
         Container(
             margin: EdgeInsets.only(left: 60, bottom: 60),
             decoration: BoxDecoration(
              color: Color.fromARGB(255, 24, 181, 254),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomLeft: Radius.circular(25))
             ),
           child: Container(
             margin: EdgeInsets.only(left: 15, right: 25),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                SizedBox(height: 50),
                 Text('Welcome',
                 style: TextStyle(fontSize: 30, 
                 color: Colors.white, 
                 fontWeight: FontWeight.bold
                   )
                 ),
                 Text('Back...',
                 style: TextStyle(
                   fontSize: 30,
                   color: Colors.white, 
                   fontWeight: FontWeight.bold
                   )
                 ),
             
                 Container(
                   alignment: Alignment.centerRight,
                   child: Image.asset('assets/img/car.png',
                   width: 150,
                   height: 150,
                   ),
                 ),
                 Text('Login',
                 style: TextStyle(
                   fontSize: 24,
                   color: Colors.white,
                   fontWeight: FontWeight.bold
                   )
                 ),
             
                 Container(
                  height: 55,
                  margin: EdgeInsets.only(top: 20, right: 16, left: 16),
                   decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                    )
                   ),
                   child: TextField(
                     decoration: InputDecoration(
                       label: Text('Email'),
                       border: InputBorder.none,
                       prefixIcon: Container(
                        margin: EdgeInsets.only(top: 10),
                         child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.email_outlined
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: Colors.grey,
                            )
                          ],
                         ),
                       )
                     ),
                   ),
                 ),
             
                 Container(
                  height: 55,
                   margin: EdgeInsets.only(top: 20, right: 16, left: 16),
                   decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                    )
                   ),
                   child: TextField(
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       label: Text('Contraseña'),
                       prefixIcon: Container(
                        margin: EdgeInsets.only(top: 10),
                         child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.lock_open_outlined
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: Colors.grey,
                            )
                          ],
                         ),
                       )
                     ),
                   ),
                 ),

                 Spacer(),
             
                 Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                   //alignment: Alignment.center,
                   margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                   child: ElevatedButton(
                     onPressed: (){}, 
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.white
                     ),
                     child: Text('Iniciar sesión',
                       style: TextStyle(
                         color: Colors.cyan,
                         fontSize: 18,
                         fontWeight: FontWeight.bold
                       )
                     )
                  ),
                 ),

                 SizedBox(height: 10),
                 
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    Container(
                      width: 25,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(right: 5.0),
                    ),
                    Text('O', 
                      style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                     ),
                    ),
                    Container(
                      width: 25,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 5.0),
                    )
                   ],
                 ),

                 SizedBox(height: 10),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No tienes cuenta ?', style: 
                    TextStyle(
                      color: Colors.grey[100],
                      fontSize: 17
                      ),
                     ),
                     SizedBox(width: 7),
                    Text('Registrate', style: 
                    TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                     ),
                    ),
                  ],
                 ),
                 SizedBox(height: 50),
               ],
             ),
           ),
         ),
      ]
    );
  }
}