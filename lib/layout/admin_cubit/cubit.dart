import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/admin_cubit/state.dart';
import 'package:food_shopping_app/model/product_model.dart';
import 'package:food_shopping_app/modules/admin/add_product_screen.dart';
import 'package:food_shopping_app/modules/admin/product_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/admin_message_model.dart';
import '../../model/user_model.dart';
import '../../model/user_note_model.dart';
import '../../modules/admin/admin_profile_screen.dart';
import '../../shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialStates());

  static AdminCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  Future<void> getUserData() async {
    emit(AdminGetUserLoadingStates());

    if (uId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        print(value.data());
        userModel = UserModel.fromJson(value.data()!);
        emit(AdminGetUserSuccessStates());
      }).catchError((err) {
        print(err.toString());
        emit(AdminGetUserErrorStates(err.toString()));
      });
    }
  }

  int currentIndex = 0;

  List<Widget> screens = [
    ProductScreen(),
    AddProductScreen(),
    AdminProfileScreen()
  ];
  List<String> titles = ['Product', 'Add Product', 'Settings'];

  Future<void> changeBottomNav(int index) async {
    if (index == 0) {
      currentIndex = index;
      getProducts();
      emit(AdminChangeBottomNavStates());
    } else if (index == 2) {
      currentIndex = index;
      getUserData();
      getNotes();
      emit(AdminChangeBottomNavStates());
    } else {
      currentIndex = index;
      emit(AdminChangeBottomNavStates());
    }
  }

  File? productImage;

  Future getProductImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      productImage = File(image.path);

      emit(AdminProductImagePickedSuccessStates());
    } else {
      print('no Image selected');
      emit(AdminProductImagePickedErrorStates());
    }
  }

  void removeProductImage() {
    productImage = null;
    emit(AdminProductImageDeletedStates());
  }

  void uploadProductImage({
    required String name,
    required int quantity,
    required double price,
  }) {
    emit(AdminAddProductLoadingStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        addProduct(name: name, image: value, quantity: quantity, price: price);
      }).catchError((err) {
        print(err.toString());
        emit(AdminAddProductErrorStates());
      });
    }).catchError((err) {
      print(err.toString());
      emit(AdminAddProductErrorStates());
    });
  }

  void addProduct({
    required String name,
    String? image,
    required int quantity,
    required double price,
  }) {
    emit(AdminAddProductLoadingStates());

    ProductModel productModel = ProductModel(
        name: name,
        image: image ??
            'https://img.freepik.com/free-photo/assorted-mixed-fruits_74190-6961.jpg?w=740&t=st=1672838066~exp=1672838666~hmac=6433d16cf2d62bad6510183b9265af4722179d4c1e3d4a823dc674281cd71975',
        price: price,
        quantity: quantity,
        count: 0);

    FirebaseFirestore.instance
        .collection('products')
        .add(productModel.toMap())
        .then((value) {
      emit(AdminAddProductSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(AdminAddProductErrorStates());
    });
  }

  List<ProductModel> products = [];
  Map<String, String> productId = {};

  Future<void> getProducts() async {
    products = [];

    emit(AdminGetProductLoadingStates());

    await FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach((element) async {
        products.add(ProductModel.fromJson(element.data()));
        productId[element.data()['name']] = element.id;

      });
    }).whenComplete(() {
      Future.delayed(const Duration(seconds: 2), () {
        emit(AdminGetProductSuccessStates());
      });
    }).catchError((error) {
      print(error.toString());
      emit(AdminGetProductErrorStates());
    });
  }

  File? profileImage;

  Future getProfileImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = File(image.path);

      emit(AdminProfileImagePickedSuccessStates());
    } else {
      print('no Image selected');
      emit(AdminProfileImagePickedErrorStates());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
  }) {
    emit(AdminUploadInfoLoadingStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          name: name,
          image: value,
          phone: phone,
        );
      }).catchError((err) {
        print(err.toString());
        emit(AdminUploadInfoErrorStates());
      });
    }).catchError((err) {
      print(err.toString());
      emit(AdminUploadInfoErrorStates());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    String? image,
  }) {
    UserModel model = UserModel(
        name: name,
        phone: phone,
        email: userModel!.email,
        image: image ?? userModel!.image,
        uId: userModel!.uId,
        isAdmin: userModel!.isAdmin);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(AdminUploadInfoSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(AdminUpdateErrorStates());
    });
  }

  File? newProductImage;

  Future getNewProductImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      newProductImage = File(image.path);

      emit(AdminProductImagePickedSuccessStates());
    } else {
      print('no Image selected');
      emit(AdminProductImagePickedErrorStates());
    }
  }

  void updateProductImage({
    required String name,
    required int quantity,
    required double price,
    required String preName,
    required int count,
  }) {
    emit(AdminAddProductLoadingStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(newProductImage!.path).pathSegments.last}')
        .putFile(newProductImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateProductDetails(
          name: name,
          image: value,
          quantity: quantity,
          price: price,
          preName: preName,
          count: count,
        );
      }).catchError((err) {
        print(err.toString());
        emit(AdminUpdateProductDetailsErrorStates());
      });
    }).catchError((err) {
      print(err.toString());
      emit(AdminUpdateProductDetailsErrorStates());
    });
  }

  void updateProductDetails({
    required String name,
    required double price,
    required int quantity,
    required String preName,
    String? image,
    required int count,
  }) {
    emit(AdminUpdateProductDetailsLoadingStates());
    ProductModel productModel = ProductModel(
      name: name,
      price: price,
      quantity: quantity,
      image: image,
      count: count,
    );
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId[preName])
        .update(productModel.toMap())
        .then((value) {
      getProducts();
      emit(AdminUpdateProductDetailsSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(AdminUpdateProductDetailsErrorStates());
    });
  }

  ProductModel? productModel;

  Future<void> getOneProduct(productId) async {
    products = [];

    emit(AdminGetOneProductLoadingStates());
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .get()
        .then((value) {
      productModel = ProductModel.fromJson(value.data()!);
      emit(AdminGetAllNotesSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AdminGetOneProductErrorStates());
    });
  }

  Future<void> sendNoteToUser({
    required UserNoteModel userNoteModel,
    required String message,
  }) async {
    AdminMessageModel adminMessageModel = AdminMessageModel(
      uId: userNoteModel.uId,
      message: message,
      productName: productModel!.name,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userNoteModel.uId)
        .collection('notifications')
        .add(adminMessageModel.toMap())
        .then((value) {
      emit(AdminSendResponseSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(AdminSendResponseErrorStates());
    });
  }

  List<UserNoteModel> notes = [];

  Future<void> getNotes() async {
    notes = [];
    emit(AdminGetAllNotesLoadingStates());

    await FirebaseFirestore.instance
        .collection('userNotes')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        notes.add(UserNoteModel.fromJson(element.data()));
      });
    }).whenComplete(() {
      Future.delayed(const Duration(seconds: 2), () {
        emit(AdminGetAllNotesSuccessStates());
      });
    }).catchError((error) {
      print(error.toString());
      emit(AdminGetAllNotesErrorStates());
    });
  }
}
