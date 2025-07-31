import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:subeya/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:subeya/src/presentation/utils/blocFormItem.dart';
import 'package:subeya/src/presentation/widgets/DefaultButton.dart';
import 'package:subeya/src/presentation/widgets/DefaultTextFieldOutlined.dart';

// ignore: must_be_immutable
class RegisterContent extends StatelessWidget {

    RegisterState? state;

   RegisterContent(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state!.formkeY,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                    Color.fromARGB(255, 12, 38, 145),
                    Color.fromARGB(255, 34, 156, 249),
                 ]
                )
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
            margin: EdgeInsets.only(left: 60, bottom: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomLeft: Radius.circular(35)
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 189, 189, 189),
                  Color.fromARGB(255, 245, 245, 245),
                ]
               ),
            ),
            child: Stack(
              children: [
                imageBackground(context),
                SingleChildScrollView(
                  child: Column(
                    children:[
                    _imageBanner(),

                    DefaultTextFieldOutlined(
                      onChanged:(text) => {
                        context.read<RegisterBloc>().add(NameChangedTextField(name: BlocFormItem(value: text)))
                      },
                      validate: (value){
                        return context.read<RegisterBloc>().state.name.error;
                      },
                      text: 'Nombre', 
                      icon: Icons.person_outline,
                      margin: EdgeInsets.only(left: 30, right: 30.0, top: 15),
                      ),

                      DefaultTextFieldOutlined(
                      onChanged:(text) => {
                        context.read<RegisterBloc>().add(LastnameChangedTextField(lastname: BlocFormItem(value: text)))
                      },
                      validate: (value){
                        return context.read<RegisterBloc>().state.lastname.error;
                      },
                      text: 'Apellido', 
                      icon: Icons.person_outline,
                      margin: EdgeInsets.only(left: 30, right: 30.0, top: 15),
                      ),
      
                      DefaultTextFieldOutlined(
                      onChanged:(text) => {
                        context.read<RegisterBloc>().add(EmailChangedTextField(email: BlocFormItem(value: text)))
                      },
                      validate: (value){
                        return context.read<RegisterBloc>().state.email.error;
                      },
                      text: 'Email', 
                      icon: Icons.email_outlined,
                      margin: EdgeInsets.only(left: 30, right: 30.0, top: 15),
                      ),
      
                      DefaultTextFieldOutlined(
                      onChanged:(text) => {
                        context.read<RegisterBloc>().add(PhoneChangedTextField(phone: BlocFormItem(value: text)))
                      },
                      validate: (value){
                        return context.read<RegisterBloc>().state.phone.error;
                      },
                      text: 'Telefono', 
                      icon: Icons.phone_outlined,
                      margin: EdgeInsets.only(left: 30, right: 30.0, top: 15),
                      ),
                      
                      DefaultTextFieldOutlined(
                      onChanged:(text) => {
                        context.read<RegisterBloc>().add(PasswordChangedTextField(password: BlocFormItem(value: text)))
                      },
                      validate: (value){
                        return context.read<RegisterBloc>().state.password.error;
                      },
                      text: 'Contraseña', 
                      icon: Icons.lock_outline,
                      margin: EdgeInsets.only(left: 30, right: 30.0, top: 15),
                      ),
      
                      DefaultTextFieldOutlined(
                      onChanged:(text) => {
                        context.read<RegisterBloc>().add(ConfirmPasswordChangedTextField(confirmPassword: BlocFormItem(value: text)))
                      },
                      validate: (value){
                        return context.read<RegisterBloc>().state.confirmPassword.error;
                      },
                      text: 'Confirmar contraseña', 
                      icon: Icons.lock_outline,
                      margin: EdgeInsets.only(left: 30, right: 30.0, top: 15),
                      ),
                  
                    DefaultButton(
                        onPressed: (){
                          if(state!.formkeY!.currentState!.validate()){
                              context.read<RegisterBloc>().add(FormRegisterSubmit());
                              context.read<RegisterBloc>().add(FormResetSubmit());
                          }
                        },
                        text: 'Crear usuario'
                        ),
                        SizedBox(height: 5.0),
                        _separateOr(),
                        yaTengoCuenta(context)
                   ]
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    Widget imageBackground(BuildContext context){
      return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(top: 300),
        width: MediaQuery.of(context).size.width*0.6,
        height: MediaQuery.of(context).size.height*0.4,
        child: Image.asset('assets/img/destination.png',
        opacity: AlwaysStoppedAnimation(0.1),),
      );
    }

    Widget _textLoginRotated(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'login'),
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
      ),
    );
  }

  Widget _textRegisterRotated(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Text(
        'Registro',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 27,
        ),
      ),
    );
  }

  Widget _imageBanner(){
    return Container(
      margin: EdgeInsets.only(top: 60),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/delivery.png',
        width: 180,
        height: 180,
        ),
    );
  }

  Widget _separateOr(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Container(
          width: 25,
          height: 1,
          color: Colors.black,
          margin: EdgeInsets.only(right: 5),
         ),
         Text('O',
         style: TextStyle(
          color: Colors.black,
          fontSize: 17.0
         ),
        ),
         Container(
          width: 25,
          height: 1,
          color: Colors.black,
          margin: EdgeInsets.only(left: 5),
         )
      ],
    );
  }

  Widget yaTengoCuenta(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ya tienes cuenta ?',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16
         ),
        ),
        SizedBox(height: 5.0,),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'login'),
          child: Text(
            ' Inicia sesión',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16
           ),
          ),
        )
      ],
    );
  }
}