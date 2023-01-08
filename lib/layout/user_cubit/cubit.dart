import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/user_cubit/state.dart';
import 'package:food_shopping_app/model/admin_message_model.dart';
import 'package:food_shopping_app/model/invoice_model.dart';
import 'package:food_shopping_app/model/user_note_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/product_model.dart';
import '../../model/user_model.dart';
import '../../shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../shared/network/remote/cache_helper.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  Future<void> getUserData() async {
    emit(ShopGetUserLoadingStates());

    if (uId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        print(value.data());
        userModel = UserModel.fromJson(value.data()!);
        emit(ShopGetUserSuccessStates());
      }).catchError((err) {
        print(err.toString());
        emit(ShopGetUserErrorStates(err.toString()));
      });
    }
  }

  List<ProductModel> products = [];
  Map<String, String> productId = {};

  Future<void> getProducts() async {
    products = [];
    //productId = {};
    emit(ShopGetProductLoadingStates());

    await FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach((element) async {
        products.add(ProductModel.fromJson(element.data()));
        // productId[]
        productId[element.data()['name']] = element.id;
        //print('-----------------------${element.data()['name'] } , ${element.id }');
      });
    }).whenComplete(() {
      Future.delayed(const Duration(seconds: 2), () {
        emit(ShopGetProductSuccessStates());
      });
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetProductErrorStates());
    });
  }

  Future<void> addProductToCart({
    required ProductModel productModel,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('cart')
        .doc(productId[productModel.name])
        .set(productModel.toMap())
        .then((value) {
      emit(ShopAddProductToCartSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(ShopAddProductToCartErrorStates());
    });
  }



  List<ProductModel> cart = [];
 Map<double, int> counts = {};
 // List<double> counts= [];

  Future<void> getAllProductInCart() async {
    cart = [];
    // counts = [];
    counts = {};

    if (cart.isEmpty) {
      emit(ShopGetCartLoadingStates());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .collection('cart')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          cart.add(ProductModel.fromJson(element.data()));
          print(element.data());
          counts[element.data()['price']] = element.data()['count'];
        });

        emit(ShopGetCartSuccessStates());
      }).whenComplete((){
        calcPrice();
      }).catchError((err) {
        print(err.toString());
        emit(ShopAGetCartErrorStates());
      });
    }
  }

  double fullPrice = 0.0;

  Future<void> calcPrice() async{

    fullPrice = 0.0;
    counts.forEach((key, value) {
      print(key);
      print(value);
      fullPrice+=(key*value);
      print(('==============> $fullPrice'));
      emit(ShopCalcPriceState());
    });
    // counts.forEach((element) {
    //   fullPrice += element;
    //   print(('==============> $fullPrice'));
    //   emit(ShopCalcPriceState());
    // });
  }

  Future<ProductModel> increaseProductQuantity(
      ProductModel productModel) async {
    ProductModel model = ProductModel(
      name: productModel.name,
      image: productModel.image,
      quantity: productModel.quantity! + 1,
      price: productModel.price,
      count: productModel.count! -1,
    );

    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId[productModel.name])
        .update(model.toMap())
        .then((value) {
      getAllProductInCart();

      emit(ShopUpdateQuantitySuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(ShopUpdateQuantityErrorStates());
    });
    return model;
  }

  Future<void> deleteProductFromCart(ProductModel productModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('cart')
        .doc(productId[productModel.name])
        .delete()
        .then((value) {
      getAllProductInCart();
      // calcPrice();
      getProducts();

      emit(ShopDeleteSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(ShopDeleteErrorStates());
    });
  }

  Future<ProductModel> decreaseProductQuantity(
      ProductModel productModel) async {
    ProductModel model = ProductModel(
      name: productModel.name,
      image: productModel.image,
      quantity: productModel.quantity! - 1,
      price: productModel.price,
      count: productModel.count! +1,
    );

    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId[productModel.name])
        .update(model.toMap())
        .then((value) {
      getAllProductInCart();
      getProducts();
      emit(ShopUpdateQuantitySuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(ShopUpdateQuantityErrorStates());
    });

    return model;
  }

  Future<void> sendNoteToAdmin({
    required String productId,
    required String note,
  }) async {
    UserNoteModel userNoteModel = UserNoteModel(
        uId: userModel!.uId,
        note: note,
        productId: productId,
        name: userModel!.name);
    await FirebaseFirestore.instance
        .collection('userNotes')
        .add(userNoteModel.toMap())
        .then((value) {
      emit(UserNoteSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(UserNoteErrorStates());
    });
  }

  List<AdminMessageModel> notifications = [];

  Future<void> getNotifications() async {
    notifications = [];
    emit(ShopGetNotificationLoadingStates());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('notifications')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        notifications.add(AdminMessageModel.fromJson(element.data()));
      });
      emit(ShopGetNotificationSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetNotificationErrorStates());
    });
  }

  Future<void> addInvoice(double total, String dateTime, int quantity) async {
    emit(ShopAddInvoiceLoadingStates());

    InvoiceModel invoiceModel =
        InvoiceModel(quantity: quantity, dateTime: dateTime, total: total);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('invoices')
        .add(invoiceModel.toMap())
        .then((value) {
      deleteCart();
      emit(ShopAddInvoiceSuccessStates());
    }).catchError((err) {
      emit(ShopAddInvoiceErrorStates());
    });
  }

  Future<void> deleteCart() async {
    cart = [];
    fullPrice = 0.0;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('cart')
        .get()
        .then((element) {
      element.docs.forEach((value) {
        value.reference.delete();
      });
      getAllProductInCart();
      emit(ShopDeleteCartSuccessStates());
    }).catchError((err) {
      emit(ShopDeleteCartErrorStates());
    });
  }

  List<InvoiceModel> invoices = [];

  Future<void> getInvoice() async {
    invoices = [];
    emit(ShopGetInvoiceLoadingStates());
    await FirebaseFirestore
    .instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('invoices')
    .orderBy('quantity')
    .get()
        .then((value) {
      value.docs.forEach((element) {
        invoices.add(InvoiceModel.fromJson(element.data()));
      });
      emit(ShopGetInvoiceSuccessStates());
    }).catchError((err){
      print(err.toString());
      emit(ShopGetInvoiceErrorStates());
    });
  }


  File? profileImage;

  Future getProfileImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = File(image.path);

      emit(UserProfileImagePickedSuccessStates());
    } else {
      print('no Image selected');
      emit(UserProfileImagePickedErrorStates());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
  }) {
    emit(UserUploadInfoLoadingStates());

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
        emit(UserUploadInfoErrorStates());
      });
    }).catchError((err) {
      print(err.toString());
      emit(UserUploadInfoErrorStates());
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
      emit(UserUploadInfoSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(UserUploadInfoErrorStates());
    });
  }

  bool dark= false;
  Future<void> changeTheme ({fromShared})async{
    emit(changeThemeLoadingStates());

    if(fromShared!=null){
      dark = fromShared;
    }
    else{
      dark = !dark;
      print(dark);
      CacheHelper.saveDate(key: 'isDark', val: dark ).then((value) {
        getProducts();
        emit(changeThemeStates());
      });
    }


  }


}
