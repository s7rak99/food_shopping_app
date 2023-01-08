import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/modules/admin/edit_admin_info.dart';
import 'package:food_shopping_app/modules/login/login_screen.dart';
import 'package:food_shopping_app/shared/component/component.dart';
import 'package:food_shopping_app/shared/network/remote/cache_helper.dart';

import '../../layout/admin_cubit/cubit.dart';
import '../../layout/admin_cubit/state.dart';
import '../../shared/constants/constants.dart';
import 'notification_page.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child:state is AdminGetUserLoadingStates && AdminCubit.get(context).userModel==null?
            LinearProgressIndicator() :
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width.toInt()<= 450?100.0:150,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
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
                              '${AdminCubit.get(context).userModel!.image}',
                            ),
                          ),
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
                              '${AdminCubit.get(context).userModel!.name}'.toUpperCase(),
                              style: TextStyle(color: Colors.pink[900], fontSize: 20.0),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              AdminCubit.get(context).userModel!.isAdmin! ? 'ADMIN' : 'USER',
                              style: TextStyle(color: Colors.pink[900], fontSize: 20.0),
                            ),

                          ],
                        ),
                      ),
                      IconButton(onPressed: (){
                        navigateTo(context, EditAdminProfile());
                      }, icon: Icon(Icons.edit , color: Colors.grey, size: 35.0,)),
                      SizedBox(width: 10.0,)
                    ],
                  ),
                ),
                SizedBox(height: 15.0,),
                Container(
                  height: MediaQuery.of(context).size.width.toInt()<= 450?100.0:150,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: (){
                      AdminCubit.get(context).getNotes().whenComplete(() {
                        navigateTo(context, AdminNotificationPage());
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15.0),
                          height: 70.0,
                          width: 70.0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(80.0),
                            ),
                          child: Icon(Icons.email_outlined, size: 35.0, color: Colors.pink[700],),
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
                                'Inbox'.toUpperCase(),
                                style: TextStyle(color: Colors.pink[900], fontSize: 20.0),
                              ),
                              SizedBox(height: 10.0,),


                            ],

                          ),
                        ),

                         SizedBox(width: 10.0,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    uId = null;
                    CacheHelper.clearData(key: 'uId');
                    isAdmin = null;
                    CacheHelper.clearData(key: 'isAdmin');
                    navigatePush(context, LoginScreen());
                  },
                  child: Text('SignOut',style: Theme.of(context).textTheme.headline3,),
                  color: Colors.pink[700],
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  height:MediaQuery.of(context).size.width.toInt()<= 450? 55.0: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                ),

              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
