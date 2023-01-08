import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/admin_cubit/cubit.dart';
import 'package:food_shopping_app/layout/admin_cubit/state.dart';

// ignore: must_be_immutable
class EditAdminProfile extends StatelessWidget {
  EditAdminProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      builder: (context, state) {
        nameController.text = AdminCubit.get(context).userModel!.name!;
        phoneController.text = AdminCubit.get(context).userModel!.phone!;

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width.toInt() <= 450
                        ? 150
                        : 250.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          margin: EdgeInsets.all(15.0),
                          height:
                              MediaQuery.of(context).size.width.toInt() <= 450
                                  ? 110.0
                                  : 160,
                          width:
                              MediaQuery.of(context).size.width.toInt() <= 450
                                  ? 110.0
                                  : 160,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AdminCubit.get(context).profileImage ==
                                      null
                                  ? NetworkImage(
                                      '${AdminCubit.get(context).userModel!.image}',
                                    )
                                  : FileImage(
                                          AdminCubit.get(context).profileImage!)
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 10.0,
                            child: IconButton(
                              onPressed: () {
                                AdminCubit.get(context).getProfileImage();
                              },
                              icon: Icon(
                                Icons.add_a_photo_outlined,
                                size:
                                    MediaQuery.of(context).size.width.toInt() <=
                                            450
                                        ? 30.0
                                        : 40.0,
                              ),
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  if (AdminCubit.get(context).profileImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  if (AdminCubit.get(context).profileImage != null)
                    MaterialButton(
                      onPressed: () {
                        AdminCubit.get(context).uploadProfileImage(
                          name: nameController.text,
                          phone: phoneController.text,
                        );
                      },
                      child: Text(
                        'Upload Image',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      color: Colors.pink[700],
                      minWidth: double.infinity,
                      textColor: Colors.white,
                      height: MediaQuery.of(context).size.width.toInt() <= 450
                          ? 55.0
                          : 100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: nameController,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        height: MediaQuery.of(context).size.width.toInt()<=450?1:3
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        label: Text('Name'),
                        prefixIcon: Icon(Icons.drive_file_rename_outline)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: phoneController,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      height: MediaQuery.of(context).size.width.toInt()<=450?1:3
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        label: Text('Phone'),
                        prefixIcon: Icon(Icons.phone)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: () {
                      AdminCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text);
                    },
                    child: Text(
                      'Edit',
                       style: Theme.of(context).textTheme.headline3,
                    ),
                    color: Colors.pink[700],
                    minWidth: double.infinity,
                    textColor: Colors.white,
                    height:     MediaQuery.of(context).size.width.toInt()<=450?55:100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
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
