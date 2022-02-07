import 'package:admin_dashboard/providers/register_form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(
        builder: (BuildContext context) {  
          
          final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);
          
          return Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.symmetric( horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints( maxWidth: 370),
              child: Form(
                key: registerFormProvider.formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty) return 'Ingrese su nombre';
                        return null; //Valido
                      },
                      onChanged: (value) => registerFormProvider.name = value,
                      style: const TextStyle( color: Colors.white ),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su nombre',
                        label: 'Nombre',
                        icon: Icons.supervised_user_circle_sharp
                      ),
                    ),
                    const SizedBox( height: 20 ),
                    TextFormField(
                      validator: (value){
                        if( !EmailValidator.validate(value ?? '') ) return 'Email no válido';
                        
                        return null;
                      },
                      onChanged: (value) => registerFormProvider.email = value,
                      style: const TextStyle( color: Colors.white ),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su correo',
                        label: 'Correo',
                        icon: Icons.email_outlined
                      ),
                    ),
                    const SizedBox( height: 20 ),
                    TextFormField(
                      validator: (value){
                        
                        if(value == null || value.isEmpty) return 'Ingrese su contraseña';
                        
                        if(value.length < 6) return 'La contraseña debe ser de 6 caracteres';
                        
                        return null; //Valido
                      },                      
                      onChanged: (value) => registerFormProvider.password = value,
                      style: const TextStyle( color: Colors.white ),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: '**************',
                        label: 'Contraseña',
                        icon: Icons.lock_outline
                      ),
                    ),
                    const SizedBox( height: 20 ),
                    
                    CustomOutlinedButton(
                      onPressed: (){
                        registerFormProvider.validateForm();
                      }, 
                      text: 'Crear cuenta'
                    ),
                    const SizedBox( height: 20 ),
                    
                    LinkText(
                      text: 'Ir al login',
                      onPressed: (){
                        Navigator.pushNamed(context, Fluroruter.loginRoute);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        );
        }
        
      ),
    );
  }

}