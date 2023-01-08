import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/admin_cubit/cubit.dart';
import 'package:food_shopping_app/layout/admin_cubit/state.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  '${AdminCubit.get(context).titles[AdminCubit.get(context).currentIndex]}', style:Theme.of(context).textTheme.bodyText1,),
            ),
            body: AdminCubit.get(context)
                .screens[AdminCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap:(value) {
                AdminCubit.get(context).changeBottomNav(value);
              },
              currentIndex: AdminCubit.get(context).currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.production_quantity_limits),
                  label: 'product',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: 'setting',
                )
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
