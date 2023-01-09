import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/admin_cubit/admin_layout.dart';
import 'package:food_shopping_app/layout/admin_cubit/cubit.dart';
import 'package:food_shopping_app/layout/user_cubit/cubit.dart';
import 'package:food_shopping_app/modules/login/cubit/cubit.dart';
import 'package:food_shopping_app/modules/register/register_screen.dart';
import 'package:food_shopping_app/shared/constants/constants.dart';

import '../../layout/user_cubit/shop_layout.dart';
import '../../shared/component/component.dart';
import '../../shared/network/remote/cache_helper.dart';
import 'cubit/state.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  bool? saves = CacheHelper.getData(key: 'rememberMe') ?? false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            toast(message: 'err', states: ToastsStates.ERROR);
          } else if (state is LoginSuccessState) {
            uId = state.uId;
            print('${state.uId}');
            LoginCubit.get(context).getUserData().then((value) {
              Future.delayed(Duration(seconds: 2)).whenComplete(() {
                if (LoginCubit.get(context).userModel!.isAdmin!) {
                  // toast(message: 'success admin', states: ToastsStates.SUCCESS);
                  CacheHelper.saveDate(
                      key: 'isAdmin',
                      val: LoginCubit.get(context).userModel!.isAdmin!);
                  CacheHelper.saveDate(key: 'uId', val: state.uId)
                      .then((value) {
                        AdminCubit.get(context).getProducts();
                        ShopCubit.get(context).getUserData();

                        navigatePush(context, AdminLayout());
                  });
                } else {
                  toast(message: 'success user', states: ToastsStates.SUCCESS);
                  CacheHelper.saveDate(
                      key: 'isAdmin',
                      val: LoginCubit.get(context).userModel!.isAdmin!);
                  print('saves');
                  CacheHelper.saveDate(key: 'uId', val: state.uId)
                      .then((value) {
                        ShopCubit.get(context).getProducts();
                        ShopCubit.get(context).getUserData();

                        navigatePush(context, ShopLayout());
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
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/foods.png',
                        height: 250,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller:
                            saves == true ? getEmail() : emailController,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40,
                            height: MediaQuery.of(context).size.width.toInt()<= 450?1:1.5
                        ),                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          prefixIcon: Icon(Icons.alternate_email, size: MediaQuery.of(context).size.width.toInt()<= 450?25:35,),
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
                        controller:
                            saves == true ? getPass() : passwordController,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40,
                            height: MediaQuery.of(context).size.width.toInt()<= 450?1:1.5
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'password must not be empty';
                          }
                          return null;
                        },
                        obscureText: LoginCubit.get(context).isPasswordShown,
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          suffixIcon: IconButton(
                            onPressed: () {
                              LoginCubit.get(context).changPasswordVisibility();
                            },
                            icon: Icon(
                              LoginCubit.get(context).suffixIcon,
                            ),
                          ),
                          prefixIcon: Icon(Icons.lock, size:MediaQuery.of(context).size.width.toInt()<= 450?25:35 ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  color: Colors.pink[700]!, width: 2.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: LoginCubit.get(context).save,
                              onChanged: (val) {
                                LoginCubit.get(context).rememberMe(val);
                                CacheHelper.saveDate(
                                    key: 'rememberMe',
                                    val: LoginCubit.get(context).save);
                                if (!LoginCubit.get(context).save) {
                                  CacheHelper.clearData(key: 'email');
                                  CacheHelper.clearData(key: 'password');
                                }
                              }),
                          Text(
                            'Remember me!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontSize: MediaQuery.of(context).size.width.toInt()<= 450?18.0:25),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      state is! LoginLoadingState
                          ? MaterialButton(
                        height: MediaQuery.of(context).size.width.toInt()<= 450?55:75,
                            minWidth: double.infinity,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (LoginCubit.get(context).save) {
                                  CacheHelper.saveDate(
                                      key: 'email',
                                      val: emailController.text);
                                  CacheHelper.saveDate(
                                      key: 'password',
                                      val: passwordController.text);
                                }
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            color: Colors.pink[700],
                            child: Text('Login',
                                style:
                                    Theme.of(context).textTheme.headline3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          )
                          : CircularProgressIndicator(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'if you do not have an account ',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width.toInt()<= 450?12.0:25,
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text('Register Now', style: TextStyle(fontSize: MediaQuery.of(context).size.width.toInt()<= 450?16:25),))],
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

  TextEditingController getEmail() {
    emailController.text = CacheHelper.getData(key: 'email') ?? '';
    return emailController;
  }

  TextEditingController getPass() {
    passwordController.text = CacheHelper.getData(key: 'password') ?? '';
    return passwordController;
  }
}
