import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/user_form_provider.dart';
import 'package:admin_dashboard/providers/users_provider.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/models/usuario.dart';

class UserView extends StatefulWidget {
  final String uid;
  const UserView({ Key? key, required this.uid }) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  
  Usuario? user;
  @override
  void initState() {
    super.initState();
    
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider = Provider.of<UserFormProvider>(context, listen: false);
    
    
    usersProvider.getUserById(widget.uid)
      .then((userDb) {
        if(userDb != null){
          userFormProvider.user = userDb;
          setState(() { user = userDb; });  
        } else {
          NavigationService.replaceTo('/dashboard/users');
        }
        
      });
    
  }
  
  @override
  void dispose() {
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).user = null;
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('User view', style: CustomLabels.h1 ),
          const SizedBox( height: 10 ),
          
            if(user == null)
                WhiteCard(
                child: Container(
                  height: 400,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ) else
              
            _UserViewBody()
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(250),
        },
        
        children: [
          TableRow(
            children: [
              //TODO: Avatar
              _AvatarContainer(),
              //TODO: Formulario de actualizacion
              _UserViewForm()
            ]
          )
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    
    return WhiteCard(
      title: 'Información general',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              initialValue: user.nombre,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Nombre del usuario',
                label: 'Nombre',
                icon: Icons.supervised_user_circle_outlined
              ),
              onChanged: ( value ) => userFormProvider.copyUserWith( nombre: value ),
              validator: (value){
                if( value == null || value.isEmpty ) return 'Ingrese un nombre';
                
                if( value.length < 2 ) return 'El nombre debe ser de dos lestra minimo';
                
                return null;
              },
            ),
            
            SizedBox( height: 20 ),
            
            TextFormField(
              initialValue: user.correo,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Correo del usuario',
                label: 'Correo',
                icon: Icons.mark_email_read_outlined
              ),
              onChanged: ( value ) =>userFormProvider.copyUserWith( correo: value ),
              validator: (value){
                      if( !EmailValidator.validate(value ?? '') ) return 'Email no válido';
                      
                      return null;
                    },
            ),
            
            SizedBox( height: 20 ),
            
            ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 110 ),
              child: ElevatedButton(
                onPressed: () async{
                  final saved = await userFormProvider.updateUser();
                  
                  if( saved ){
                    NotificationsService.showSnackbar('Usuario actualizados');
                    
                    Provider.of<UsersProvider>(context, listen: false).refreshUser(user);
                  }
                }, 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all( Colors.indigo ),
                  shadowColor: MaterialStateProperty.all( Colors.transparent )
                ),
                child: Row(
                  children: [
                    Icon( Icons.save_outlined, size: 20 ),
                    Text(' Guardar')
                  ],
                )
              ),
            )
            
          ],
        ),
      )
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    
    return WhiteCard(
      width: 250,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile', style: CustomLabels.h2 ),
            SizedBox( height: 20 ),
            Container(
              width: 150,
              height: 160,
              child: Stack(
                
                children: [
                  ClipOval(
                    child: Image(
                      image: AssetImage('no-image.jpg'),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all( color: Colors.white, width: 5)
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        elevation: 0,
                        child: Icon( Icons.camera_alt_outlined, size: 20,),
                        onPressed: (){
                          //TODO: Seleccionar la imagen
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox( height: 20,),
            
            Text(
              user.nombre,
              style: TextStyle( fontWeight: FontWeight.bold)
            )
          ],
        ),
      )
    );
  }
}