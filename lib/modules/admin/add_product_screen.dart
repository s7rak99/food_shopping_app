import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/admin_cubit/admin_layout.dart';
import 'package:food_shopping_app/modules/admin/product_screen.dart';
import 'package:food_shopping_app/shared/component/component.dart';

import '../../layout/admin_cubit/cubit.dart';
import '../../layout/admin_cubit/state.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key}) : super(key: key);

  var productName = TextEditingController();
  var productPrice = TextEditingController();
  var productQuantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          var productImage = AdminCubit.get(context).productImage;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is AdminAddProductLoadingStates)
                          const LinearProgressIndicator(),
                        if (state is AdminAddProductLoadingStates)
                          const SizedBox(
                            height: 10,
                          ),
                        TextFormField(
                          controller: productName,
                          decoration: InputDecoration(
                              hintText: 'Please Enter Product Name',
                              prefixIcon: Icon(Icons.fastfood_rounded),
                              border: InputBorder.none),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: productPrice,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: '0.0',
                                    prefixIcon:
                                        Icon(Icons.attach_money_rounded),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: productQuantity,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    prefixIcon: Icon(Icons.numbers),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        if (productImage != null)
                          Stack(
                            children: [
                              Image(image: FileImage(productImage)),
                              IconButton(
                                  onPressed: () {
                                    AdminCubit.get(context)
                                        .removeProductImage();
                                  },
                                  icon: Icon(Icons.clear)),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          if(productImage == null){
                            AdminCubit.get(context).addProduct(
                              name: productName.text,
                              quantity: int.parse(productQuantity.text),
                              price: double.parse(productPrice.text),
                            );
                          }
                          else{
                            AdminCubit.get(context).uploadProductImage(
                              name: productName.text,
                              quantity: int.parse(productQuantity.text),
                              price: double.parse(productPrice.text),
                            );

                          }
                        },
                        child: Text('Add', style: Theme.of(context).textTheme.headline3,),
                        height:MediaQuery.of(context).size.width.toInt()<= 450? 50:100,
                        color: Colors.pink[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(
                      onPressed: () {
                        AdminCubit.get(context).getProductImage();
                      },
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        size: 35,
                        color: Colors.pink[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                )
              ],
            ),
          );
        },
        listener: (context, state) {
          if(state is AdminAddProductSuccessStates){
            productName.clear();
            productQuantity.clear();
            productPrice.clear();
            AdminCubit.get(context).removeProductImage();
            AdminCubit.get(context).getProducts();
            AdminCubit.get(context).currentIndex = 0;
            navigatePush(context, AdminLayout());
          }
        });
  }
}
