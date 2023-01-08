import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/model/product_model.dart';
import 'package:food_shopping_app/modules/admin/edit_product_details.dart';
import 'package:food_shopping_app/shared/component/component.dart';

import '../../layout/admin_cubit/cubit.dart';
import '../../layout/admin_cubit/state.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          return state is AdminGetProductLoadingStates?
            Center(child: CircularProgressIndicator()):
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.count(
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio:MediaQuery.of(context).size.width.toInt() <= 450 ? 0.9:
                MediaQuery.of(context).orientation== Orientation.landscape? 1: 1.2,                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(AdminCubit.get(context).products.length,
                    (index) {
                  return buildProductItem(
                      AdminCubit.get(context).products[index], context);
                }),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget buildProductItem(ProductModel productModel, context) {
    return InkWell(
      onTap: (){
        navigateTo(context, EditProductDetails(productModel));
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.pink[100],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.width.toInt()<= 450? 110.0: 180.0,
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Image.network(
                  '${productModel.image}', fit: BoxFit.cover,),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('${productModel.name}', style: Theme.of(context).textTheme.bodyText1,),
            SizedBox(height:MediaQuery.of(context).size.width.toInt()<= 450? 5.0:15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${productModel.price } JD', style: Theme.of(context).textTheme.subtitle1,),
                Text('# ${productModel.quantity }', style: Theme.of(context).textTheme.subtitle1,),

                //IconButton(onPressed: () {}, icon: Icon(Icons.add_shopping_cart))
              ],
            )
          ],
        ),
      ),
    );
  }
}
