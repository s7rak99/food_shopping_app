import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/admin_cubit/cubit.dart';
import 'package:food_shopping_app/layout/admin_cubit/state.dart';
import 'package:food_shopping_app/shared/component/component.dart';

import '../../model/user_note_model.dart';
import 'edit_product_details.dart';

class MessageScreen extends StatelessWidget {
  UserNoteModel userNoteModel;

  MessageScreen(this.userNoteModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Message from ${userNoteModel.name}',
                          style: Theme.of(context).textTheme.headline5!
                          .copyWith(
                            fontSize: 28
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          '${userNoteModel.note}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: MediaQuery.of(context)
                                              .size
                                              .width
                                              .toInt() <=
                                          450
                                      ? 20.0
                                      : 50.0),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            AdminCubit.get(context)
                                .getOneProduct(userNoteModel.productId)
                                .whenComplete(() {
                              // print('hereeeeeeeeeeeeeeeeeeeeee ${value!.name}');
                              navigateTo(
                                  context,
                                  EditProductDetails(
                                      AdminCubit.get(context).productModel!));
                            });
                          },
                          child: Text(
                            'Edit',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          color: Colors.pink[700],
                          minWidth: double.infinity,
                          textColor: Colors.white,
                          height:
                              MediaQuery.of(context).size.width.toInt() <= 450
                                  ? 55.0
                                  : 100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            if (AdminCubit.get(context).productModel != null) {
                              AdminCubit.get(context).sendNoteToUser(
                                  userNoteModel: userNoteModel,
                                  message: 'the product updated please check');
                              Navigator.of(context).pop();
                            } else
                              toast(
                                  message: 'please update it first',
                                  states: ToastsStates.WARNING);
                          },
                          child: Text(
                            'Notify',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          color: Colors.pink[700],
                          minWidth: double.infinity,
                          textColor: Colors.white,
                          height:
                              MediaQuery.of(context).size.width.toInt() <= 450
                                  ? 55.0
                                  : 100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
