import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/modules/login/login_screen.dart';
import 'package:food_shopping_app/modules/register/register_cubit/cubit.dart';
import 'package:food_shopping_app/modules/register/register_cubit/state.dart';

import '../../layout/admin_cubit/admin_layout.dart';
import '../../layout/user_cubit/shop_layout.dart';
import '../../shared/component/component.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/remote/cache_helper.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterCreateUserSuccessState) {
            uId = state.uId;
            print('${state.uId}');
            RegisterCubit.get(context).getUserData().then((value) {
              Future.delayed(Duration(seconds: 2)).whenComplete(() {
                if (RegisterCubit.get(context).userModel!.isAdmin!) {
                  CacheHelper.saveDate(key: 'isAdmin', val: RegisterCubit.get(context).userModel!.isAdmin!);
                  CacheHelper.saveDate(key: 'uId', val: state.uId)
                      .then((value) {
                    navigatePush(context, AdminLayout());
                  });
                } else {
                  toast(message: 'success user', states: ToastsStates.SUCCESS);
                  CacheHelper.saveDate(key: 'isAdmin', val: RegisterCubit.get(context).userModel!.isAdmin!);
                  print('saves');
                  CacheHelper.saveDate(key: 'uId', val: state.uId)
                      .then((value) {
                    RegisterCubit.get(context).getUserData().whenComplete(() {
                      navigatePush(context, ShopLayout());

                    }) ;
                  });
                }
              });
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Column(
                    children: [
                      Image.asset('images/foods.png', height: 250 , width: 250, fit: BoxFit.cover,),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: nameController,
                        style:  Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40,
                            height: MediaQuery.of(context).size.width.toInt()<= 450?1:1.5
                        ),

                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Name'),
                          prefixIcon:
                              const Icon(Icons.drive_file_rename_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  color: Colors.pink[700]!, width: 2.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        style:  Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40,
                            height: MediaQuery.of(context).size.width.toInt()<= 450?1:1.5
                        ),

                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          prefixIcon: const Icon(Icons.alternate_email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  color: Colors.pink[700]!, width: 2.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        style:  Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40,
                            height: MediaQuery.of(context).size.width.toInt()<= 450?1:1.5
                        ),

                        controller: phoneController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'phone number must not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Phone Number'),
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  color: Colors.pink[700]!, width: 2.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        style:  Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40,
                            height: MediaQuery.of(context).size.width.toInt()<= 450?1:1.5
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'password must not be empty';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  color: Colors.pink[700]!, width: 2.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      state is! RegisterLoadingState
                          ? SizedBox(
                              width: double.infinity,
                              height: 58.0,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                color: Colors.pink[700],
                                child: Text(
                                  'Register',
                                  style: Theme.of(context).textTheme.headline3
                                ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              )
                          : CircularProgressIndicator(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'if you already have an account ',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                navigatePush(context, LoginScreen());
                              },
                              child: Text('Login Now'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
