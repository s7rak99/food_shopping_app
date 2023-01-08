import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/user_cubit/cubit.dart';
import 'package:food_shopping_app/layout/user_cubit/state.dart';
import 'package:food_shopping_app/modules/user/cart.dart';
import 'package:food_shopping_app/modules/user/user_notification_screen.dart';
import 'package:food_shopping_app/shared/component/component.dart';

import '../../model/product_model.dart';
import '../../modules/login/login_screen.dart';
import '../../modules/user/edit_user_info.dart';
import '../../modules/user/invoice_screen.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/remote/cache_helper.dart';



class ShopLayout extends StatelessWidget {
  ShopLayout({Key? key}) : super(key: key);

  var notesController = TextEditingController();

  var keys = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopGetUserSuccessStates) {
          ShopCubit.get(context).getNotifications();
        }
        if(state is changeThemeStates){

        }

      },
      builder: (context, state) {
        return Scaffold(
          key: keys,
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                ShopCubit.get(context).changeTheme();
              }, icon: Icon(Icons.dark_mode,color: Colors.pink[700],)),
              SizedBox(width: 10.0,)
            ],
            title: Text(
              'Sahar Shop',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          drawer: Drawer(
            child: ShopCubit.get(context).products.isEmpty &&
                    ShopCubit.get(context).userModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Stack(
                        alignment: FractionalOffset.bottomRight,
                        children: [
                          Container(
                            height: 300.0,
                            color: Colors.pink[100],
                            padding: EdgeInsets.only(top: 35.0),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(15.0),
                                  height: 70.0,
                                  width: 70.0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        '${ShopCubit.get(context).userModel!.image!}',
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${ShopCubit.get(context).userModel!.name}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.pink[700],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      '${ShopCubit.get(context).userModel!.email}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.pink[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.bottomRight,
                            child: IconButton(
                              onPressed: () {
                                navigateTo(context, EditUserProfile());
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey,
                                size: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                print('${CacheHelper.getData(key: 'isDark')}');
                                keys.currentState!.closeDrawer();
                              },
                              child: ListTile(
                                title: Text('Home',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                leading: Icon(
                                  Icons.home,
                                  color: Colors.pink,
                                  size: 30.0,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ShopCubit.get(context)
                                    .getAllProductInCart()
                                    .then((value) {
                                  navigateTo(context, Cart());
                                  // ShopCubit.get(context).calcPrice().whenComplete(() =>
                                  //     navigateTo(context, Cart()));
                                  print('Iam here');

                                });
                              },
                              child: ListTile(
                                title: Text('Cart',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                leading: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.pink,
                                  size: 30.0,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ShopCubit.get(context)
                                    .getNotifications()
                                    .whenComplete(() {
                                  navigateTo(context, UserNotificationScreen());
                                });
                              },
                              child: ListTile(
                                title: Text(
                                    'Notification (${ShopCubit.get(context).notifications.length})',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                // trailing: Text('0' , style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                //   color: Colors.pink[700]
                                // ),),
                                leading: Icon(
                                  Icons.notifications_active,
                                  color: Colors.pink,
                                  size: 30.0,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ShopCubit.get(context)
                                    .getInvoice()
                                    .whenComplete(() {
                                  navigateTo(context, InvoicePage());
                                });
                              },
                              child: ListTile(
                                title: Text('Invoice',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                leading: Icon(
                                  Icons.money,
                                  color: Colors.pink,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          uId = null;
                          CacheHelper.clearData(key: 'uId');
                          isAdmin = null;
                          CacheHelper.clearData(key: 'isAdmin');
                          navigatePush(context, LoginScreen());
                        },
                        child: ListTile(
                          title: Text(
                            'Sign Out',
                              style: Theme.of(context).textTheme.bodyText1

                          ),
                          leading: Icon(
                            Icons.login_outlined,
                            color: Colors.pink,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          body: ShopCubit.get(context).products.isEmpty ||
                  ShopCubit.get(context).userModel == null || state is changeThemeLoadingStates

              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: LinearProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GridView.count(
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio:MediaQuery.of(context).size.width.toInt() <= 450 ? 0.9:
                      MediaQuery.of(context).orientation== Orientation.landscape? 1: 1.2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(
                          ShopCubit.get(context).products.length, (index) {
                        return buildProductItem(
                            ShopCubit.get(context).products[index], context);
                      }),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget buildProductItem(ProductModel productModel, context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                height:  MediaQuery.of(context).size.width.toInt()<= 450? 110.0: 210.0,
                width: double.infinity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: Image.network(
                  '${productModel.image}',
                  fit: BoxFit.cover,
                ),
              ),
              CircleAvatar(
                radius:MediaQuery.of(context).size.width.toInt()<= 450? 12.0:20,
                child: Text(
                  '${productModel.quantity}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white,fontSize: MediaQuery.of(context).size.width.toInt()<= 450?14:25,),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        '${productModel.name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(overflow: TextOverflow.ellipsis, ),
                      )),
                      InkWell(
                        onTap: () {
                          if (productModel.quantity! > 0) {
                            ShopCubit.get(context)
                                .decreaseProductQuantity(productModel)
                                .then((value) {
                              ShopCubit.get(context)
                                  .addProductToCart(productModel: value)
                                  .then((value) {});
                              toast(
                                  message: 'added Successfully',
                                  states: ToastsStates.SUCCESS);
                            });
                          } else {
                            showDialog(
                                context: (context),
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Do You Want notify?'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('if you have any note.'),
                                          TextFormField(
                                            controller: notesController,
                                            decoration: InputDecoration(
                                              label: Text(
                                                  'Write yor message here...'),
                                              prefixIcon:
                                                  Icon(Icons.note_alt_outlined),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Send'),
                                        onPressed: () {
                                          // setState((){
                                          ShopCubit.get(context)
                                              .sendNoteToAdmin(
                                            productId: ShopCubit.get(context)
                                                .productId[productModel.name]!,
                                            note: notesController.text,
                                          )
                                              .whenComplete(() {
                                            Navigator.of(context).pop();
                                          });
                                          // });
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        child: Icon(Icons.add_shopping_cart_outlined, size: MediaQuery.of(context).size.width.toInt()<= 450?22:37,),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${productModel.price} JD',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width.toInt()<= 450?14:20
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
