import 'package:flutter/material.dart';
import 'package:food_shopping_app/layout/admin_cubit/cubit.dart';
import 'package:food_shopping_app/shared/component/component.dart';

import '../../model/user_note_model.dart';
import 'message_screen.dart';

class AdminNotificationPage extends StatelessWidget {
  const AdminNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INBOX'),
      ),
      body: SingleChildScrollView(
        child: AdminCubit.get(context).notes.isEmpty &&  AdminCubit.get(context).userModel==null?
            Center(child: CircularProgressIndicator(),):
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildNotifyItem(context, AdminCubit.get(context).notes[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20,);
            },
            itemCount: AdminCubit.get(context).notes.length,
          ),
        ),
      ),
    );
  }

  Widget buildNotifyItem(context, UserNoteModel userNoteModel) {
    return Container(
      height: MediaQuery.of(context).size.width.toInt()<= 450?100.0:150.0,
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          navigateTo(context, MessageScreen(userNoteModel));
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(15.0),
              height: MediaQuery.of(context).size.width.toInt()<= 450?70.0:100,
              width: MediaQuery.of(context).size.width.toInt()<= 450?70.0:100.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(80.0),
              ),
              child: Icon(
                Icons.email_outlined,
                size: 35.0,
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
                    '${userNoteModel.name}'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width.toInt()<= 450?20:40.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${userNoteModel.note}'.toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: MediaQuery.of(context).size.width.toInt()<= 450?14:20.0
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
      ),
    );
  }
}
