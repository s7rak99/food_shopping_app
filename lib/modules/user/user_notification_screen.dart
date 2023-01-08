import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/user_cubit/cubit.dart';
import 'package:food_shopping_app/layout/user_cubit/state.dart';

import '../../model/admin_message_model.dart';

class UserNotificationScreen extends StatelessWidget {
  UserNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('NOTIFICATIONS'),
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: ShopCubit.get(context).notifications.isEmpty &&
                  ShopCubit.get(context).userModel == null
                  ? LinearProgressIndicator()
                  : ListView.separated(
                itemBuilder: (context, index) {
                  return buildNotifyItem(
                      context, ShopCubit.get(context).notifications[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.0,
                  );
                },
                itemCount: ShopCubit.get(context).notifications.length,
              ),
            )
          );
        },
        listener: (context, state) {});
  }

  Widget buildNotifyItem(context, AdminMessageModel adminMessageModel) {
    return Container(
      height: MediaQuery.of(context).size.width.toInt()<=450?100.0:150.0,
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(15.0),
            height: MediaQuery.of(context).size.width.toInt()<= 450?70.0:100,
            width: MediaQuery.of(context).size.width.toInt()<= 450?70.0:100,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80.0),
            ),
            child: Icon(
              Icons.email_outlined,
              size: MediaQuery.of(context).size.width.toInt()<= 450?35.0:50,
              color: Colors.pink[700],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${adminMessageModel.productName}'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40

                  ),                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${adminMessageModel.message}'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width.toInt()<= 450?14:20
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }
}
