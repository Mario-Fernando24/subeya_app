import 'package:flutter/material.dart';
import 'package:subeya/src/presentation/bloc/bloc_login/LoginBloc.dart';
import 'package:subeya/src/presentation/bloc/bloc_login/LoginEvent.dart';
import 'package:subeya/src/presentation/bloc/bloc_login/LoginState.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';
import 'package:subeya/src/presentation/widgets/DefaultButton.dart';
import 'package:subeya/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginContent extends StatelessWidget {

  LoginState? state;

   LoginContent(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state!.formkey,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 15),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textLoginRotated(context),
                SizedBox(height: 100),
                _textRegisterRotated(context),
                SizedBox(height: MediaQuery.of(context).size.height*0.25),
      
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 60, bottom: 60),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 14, 29, 166),
                  Color.fromARGB(255, 30, 112, 227),
                ],
              ),
              //color: Color.fromARGB(255, 24, 181, 254),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(25),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 25),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    _textWelcome('Welcome'),
                    _textWelcome('Back...'),
                    _imageCar(),
                    _textLogin(),
                    DefaultTextField(
                      onChanged:(text) => {
                      context.read<LoginBloc>().add(EmailChanged(email: BlocFormItem(value: text)))
                      },
                      text: 'Correo',
                       icon: Icons.email_outlined,
                        validate: (value){
                        return context.read<LoginBloc>().state.email.error;
                      },
                       ),
                    DefaultTextField(
                       onChanged:(text) => {
                          context.read<LoginBloc>().add(PasswordChanged(password: BlocFormItem(value: text)))
                      },
                      text: 'Contraseña',
                      icon: Icons.lock_open_outlined,
                      validate: (value){
                        return context.read<LoginBloc>().state.password.error;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.2),
                    DefaultButton(
                      onPressed: (){
                        if(state!.formkey!.currentState!.validate()){
                        context.read<LoginBloc>().add(FormSubmit());

                        }else{
                          print("mario fernando##########################################");
                          print("El formulario no es valido");
                          print("mario fernando##########################################");

                        }
                      },
                      text: 'Iniciar sesión'
                      ),
                    SizedBox(height: 10),
                    _textSeparated(),
                    SizedBox(height: 10),
                    _textNotienesCuenta(context),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textWelcome(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _imageCar() {
    return Container(
      alignment: Alignment.centerRight,
      child: Image.asset('assets/img/car.png', width: 150, height: 150),
    );
  }

  Widget _textLogin() {
    return Text(
      'Login',
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _textLoginRotated(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 27,
        ),
      ),
    );
  }

  Widget _textRegisterRotated(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          'Registro',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
      ),
    );
  }

  Widget _textSeparated() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 25,
          height: 1,
          color: Colors.white,
          margin: EdgeInsets.only(right: 5.0),
        ),
        Text(
          'O',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        Container(
          width: 25,
          height: 1,
          color: Colors.white,
          margin: EdgeInsets.only(left: 5.0),
        ),
      ],
    );
  }

  Widget _textNotienesCuenta(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes cuenta ?',
          style: TextStyle(color: Colors.grey[100], fontSize: 17),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'register'),
          child: Text(
            'Registrate',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
