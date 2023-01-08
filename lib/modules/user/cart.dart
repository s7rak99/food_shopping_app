import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/user_cubit/cubit.dart';
import 'package:food_shopping_app/layout/user_cubit/state.dart';
import 'package:food_shopping_app/model/product_model.dart';
import 'package:jiffy/jiffy.dart';

import '../../shared/component/component.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('MY CART'),
            ),
            body: ShopCubit.get(context).cart.isEmpty ||
                    ShopCubit.get(context).userModel == null
                ? Center(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 50.0,
                      color: Colors.grey,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ShopCubit.get(context).cart.length,
                              itemBuilder: (context, index) {
                                return buildCartItem(
                                    ShopCubit.get(context).cart[index],
                                    context);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 20.0,
                                );
                              },
                            ),
                          ),
                        ),
                        Text(
                          'Total price: ${ShopCubit.get(context).fullPrice}',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40

                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        MaterialButton(
                          onPressed: () {
                            ShopCubit.get(context).addInvoice(
                              ShopCubit.get(context).fullPrice,
                              Jiffy(DateTime.now()).yMMMd.toString(),
                              ShopCubit.get(context).cart.length,
                            );
                          },

                          child: Text(
                            'Buy',
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: MediaQuery.of(context).size.width.toInt()<= 450?22:30
                            ),
                          ),
                          color: Colors.pink[700],
                          minWidth: double.infinity,
                          textColor: Colors.white,
                          height: MediaQuery.of(context).size.width.toInt()<= 450?55.0:75,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ],
                    ),
                  ),
          );
        },
        listener: (context, state) {});
  }

  Widget buildCartItem(ProductModel productModel, context) {
    return Container(
      height: 110.0,
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            width: 100.0,
            height: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Image.network(
              '${productModel.image}',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${productModel.name}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:30

                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  '${productModel.price} JD',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:30

                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // IconButton(
              //     onPressed: () {
              //       ShopCubit.get(context)
              //           .deleteProductFromCart(productModel)
              //           .then((value) {
              //         ShopCubit.get(context)
              //             .increaseProductQuantity(productModel);
              //       });
              //     },
              //     icon: Icon(
              //       Icons.delete_outline,
              //       color: Colors.pink[700],
              //       size: 35.0,
              //     )),
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width.toInt()<= 450?35:50,
                      height: MediaQuery.of(context).size.width.toInt()<= 450?35:50,
                      child: TextButton(
                          onPressed: () {
                            if(productModel.count==1) {
                              ShopCubit.get(context)
                                  .deleteProductFromCart(productModel)
                                  .then((value) {
                                ShopCubit.get(context)
                                    .increaseProductQuantity(productModel);
                              });
                            }
                            else{
                              ShopCubit.get(context)
                                  .increaseProductQuantity(productModel)
                                  .then((value) {
                                ShopCubit.get(context)
                                    .addProductToCart(productModel: value)
                                    .then((value) {});
                                toast(
                                    message: 'added Successfully',
                                    states: ToastsStates.SUCCESS);
                              });
                              // ShopCubit.get(context)
                              //     .increaseProductQuantity(productModel);
                            }
                          },
                          child: Text(
                            '-',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40
                            ),
                          ))),
                  Text(
                    '${productModel.count}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40

                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width.toInt()<= 450?35:50,
                      height:  MediaQuery.of(context).size.width.toInt()<= 450?35:50,
                      child: TextButton(
                          onPressed: () {
                            if(productModel.quantity==0){
                              toast(message: 'product quantity finish', states: ToastsStates.SUCCESS);
                            }else {
                              ShopCubit.get(context)
                                  .decreaseProductQuantity(productModel)
                                  .then((value) {
                                ShopCubit.get(context)
                                    .addProductToCart(productModel: value)
                                    .then((value) {});
                                toast(
                                    message: 'added Successfully',
                                    states: ToastsStates.ERROR);
                              });
                            }
                          },
                          child: Text(
                            '+',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40
                            ),
                          ))),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }
}
