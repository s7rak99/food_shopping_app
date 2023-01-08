import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/modules/login/cubit/state.dart';


import '../../../model/user_model.dart';
import '../../../shared/constants/constants.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
      print('login success');

    }).catchError((err){
      emit(LoginErrorState(err.toString()));
    });
  }


  UserModel? userModel;

  Future<void> getUserData() async{
    emit(LoginGetUserLoadingStates());

    if (uId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        print(value.data());
        userModel = UserModel.fromJson(value.data()!);
        print('${userModel!.name}');
        emit(LoginGetUserSuccessStates());
      }).catchError((err) {
        print(err.toString());
        emit(LoginGetUserErrorStates());
      });
    }
  }


  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changPasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  bool save=false;

  void rememberMe(val) {
    save = val;
    print(save);
    emit(LoginRememberState());
  }
}
