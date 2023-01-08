import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/modules/register/register_cubit/state.dart';

import '../../../model/user_model.dart';
import '../../../shared/constants/constants.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String email,
        required String password,
        required String name,
        required String phone}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {

      createUser(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
      print(value.user!.email);
      print(value.user!.uid);

      // emit(RegisterSuccessState());
    }).catchError((err) {
      emit(RegisterErrorState(err.toString()));
    });
  }

  void createUser(
      {required String email,
        required String name,
        required String phone,
        required String uId}) {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isAdmin: false,
        image: 'https://cdn-icons-png.flaticon.com/512/145/145968.png?w=740&t=st=1672851657~exp=1672852257~hmac=39e5be28af482291897dd4fe26983af61981dcb30a8793a9ae555609746c2643',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
          print('done');

      emit(RegisterCreateUserSuccessState(uId));
    }).catchError((err) {
      emit(RegisterCreateUserErrorState(err.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changPasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  UserModel? userModel;

  Future<void> getUserData() async{
    emit(RegisterGetUserLoadingState());

    if (uId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        print(value.data());
        userModel = UserModel.fromJson(value.data()!);
        print('${userModel!.name}');
        emit(RegisterGetUserSuccessState());
      }).catchError((err) {
        print(err.toString());
        emit(RegisterGetUserErrorState());
      });
    }
  }


}
