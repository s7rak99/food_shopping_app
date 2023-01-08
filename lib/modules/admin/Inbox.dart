import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Inbox extends StatelessWidget {
  const Inbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(builder: (context, state){
      return Scaffold();
    }, listener: (context, state){},);
  }
}
