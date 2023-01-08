import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/admin_cubit/admin_layout.dart';
import 'package:food_shopping_app/layout/admin_cubit/cubit.dart';
import 'package:food_shopping_app/layout/admin_cubit/state.dart';
import 'package:food_shopping_app/model/product_model.dart';
import 'package:food_shopping_app/shared/component/component.dart';

class EditProductDetails extends StatelessWidget {
  EditProductDetails(ProductModel this.productModel, {Key? key})
      : super(key: key);
  ProductModel productModel;

  var productNameController = TextEditingController();

  var productPriceController = TextEditingController();

  var productQuantityController = TextEditingController();

  var preName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AdminUpdateProductDetailsSuccessStates) {
         navigatePush(context, AdminLayout());
         AdminCubit.get(context).changeBottomNav(0);
        }
      },
      builder: (context, state) {
        productNameController.text = productModel.name!;
        productPriceController.text = productModel.price.toString();
        productQuantityController.text = productModel.quantity.toString();
        preName = productModel.name;
        return Scaffold(
          appBar: AppBar(title: Text('EDIT'),),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: AdminCubit.get(context)
                                                .newProductImage ==
                                            null
                                        ? Image.network(
                                            '${productModel.image}',
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(AdminCubit.get(context)
                                            .newProductImage!),
                                  ),
                                  Positioned(
                                    right: MediaQuery.of(context).size.width.toInt()<= 450?10.0:60.0,
                                    top: MediaQuery.of(context).size.width.toInt()<= 450?10.0:30.0,
                                    child: IconButton(
                                      onPressed: () {
                                        AdminCubit.get(context)
                                            .getNewProductImage();
                                      },
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.grey,
                                        size: MediaQuery.of(context).size.width.toInt()<= 450?30.0:60,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: productNameController,
                                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                          fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40,
                                          height: MediaQuery.of(context).size.width.toInt()<= 450?1:1.5
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        label: Text('Product Name'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    TextFormField(
                                      controller: productPriceController,
                                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                        fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40,
                                        height: MediaQuery.of(context).size.width.toInt()<= 450?1:1.5
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        label: Text('Product Price'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    TextFormField(
                                      controller: productQuantityController,
                                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                          fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40,
                                          height: MediaQuery.of(context).size.width.toInt()<= 450?1:1.5
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        label: Text('Product Quantity'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        if (AdminCubit.get(context)
                                                .newProductImage ==
                                            null) {
                                          AdminCubit.get(context)
                                              .updateProductDetails(
                                                  name: productNameController
                                                      .text,
                                                  price: double.parse(
                                                      productPriceController
                                                          .text),
                                                  quantity: int.parse(
                                                      productQuantityController
                                                          .text),
                                                  preName: preName,
                                                  image: productModel.image, count: productModel.count!);
                                        } else {
                                          AdminCubit.get(context)
                                              .updateProductImage(
                                                  name: productNameController
                                                      .text,
                                                  quantity: int.parse(
                                                      productQuantityController
                                                          .text),
                                                  price: double.parse(
                                                      productPriceController
                                                          .text),
                                                  preName: preName,
                                          count: productModel.count!);
                                        }
                                      },
                                      child: Text(
                                        'Edit',
                                        style: Theme.of(context).textTheme.headline3,),
                                      color: Colors.pink[700],
                                      minWidth: double.infinity,
                                      textColor: Colors.white,
                                      height:  MediaQuery.of(context).size.width.toInt()<=450?55.0:75,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
