import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/user_cubit/cubit.dart';
import '../../layout/user_cubit/state.dart';

class EditUserProfile extends StatelessWidget {
  EditUserProfile({Key? key}) : super(key: key);
   var nameController = TextEditingController();

   var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {

        nameController.text = ShopCubit.get(context).userModel!.name!;
        phoneController.text = ShopCubit.get(context).userModel!.phone!;

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.pink[100],
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          margin: EdgeInsets.all(15.0),
                          height: 110.0,
                          width: 110.0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: ShopCubit.get(context).profileImage == null?
                                NetworkImage(
                                '${ShopCubit.get(context).userModel!.image}',
                              ):
                              FileImage(ShopCubit.get(context).profileImage!) as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 10.0,
                            child: IconButton(
                              onPressed: () {
                                ShopCubit.get(context).getProfileImage();
                                //AdminCubit.get(context).uploadProductImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                              },
                              icon: Icon(
                                Icons.add_a_photo_outlined,
                                size: 30.0,
                              ),
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  if(ShopCubit.get(context).profileImage!=null)
                    SizedBox(
                      height: 20.0,
                    ),
                  if(ShopCubit.get(context).profileImage!=null)
                    MaterialButton(
                      onPressed: () {
                        ShopCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text);
                      },
                      child: Text('Upload Image', style: TextStyle(fontSize: 20.0),),
                      color: Colors.pink[700],
                      minWidth: double.infinity,
                      textColor: Colors.white,
                      height: 55.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                    ),

                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: nameController,
                    style:  Theme.of(context).textTheme.headline3,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        label: Text('Name',),
                        prefixIcon: Icon(Icons.drive_file_rename_outline, size: 30,)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: phoneController,
                    style:  Theme.of(context).textTheme.headline3,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        label: Text('Phone'),
                        prefixIcon: Icon(Icons.phone, size: 30,)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: () {
                      ShopCubit.get(context).updateUserData(name: nameController.text, phone: phoneController.text);
                    },
                    child: Text('Edit',style: Theme.of(context).textTheme.headline3,),
                    color: Colors.pink[700],
                    minWidth: double.infinity,
                    height: 55.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
