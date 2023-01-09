import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shopping_app/layout/admin_cubit/cubit.dart';
import 'package:food_shopping_app/layout/user_cubit/cubit.dart';
import 'package:food_shopping_app/layout/user_cubit/shop_layout.dart';
import 'package:food_shopping_app/layout/user_cubit/state.dart';
import 'package:food_shopping_app/modules/login/login_screen.dart';
import 'package:food_shopping_app/shared/bloc_observer.dart';
import 'package:food_shopping_app/shared/constants/constants.dart';
import 'package:food_shopping_app/shared/network/remote/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/admin_cubit/admin_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  isAdmin = CacheHelper.getData(key: 'isAdmin') ?? false;
  bool? isDark = CacheHelper.getData(key: 'isAdmin');
  Widget? firstWidget;
  if (uId != null && isAdmin != null) {
    if (isAdmin == true)
      firstWidget = AdminLayout();
    else
      firstWidget = ShopLayout();
  } else {
    firstWidget = LoginScreen();
  }

  runApp(MyApp(firstWidget, isDark));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  Widget? firstWidget;
  bool? isDark;

  MyApp(this.firstWidget, this.isDark, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool s = false;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        s = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AdminCubit()
                ..getProducts()
                ..getUserData()
                ..getNotes()),
          BlocProvider(
              create: (context) => ShopCubit()
                ..getTheme()
                ..getUserData()
                  ..getProducts()
                ),
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
            builder: (context, state) {
              return MaterialApp(
                themeMode: ShopCubit.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: Builder(
                  builder: (context) {
                    return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor:
                              MediaQuery.of(context).size.width.toInt() <= 450
                                  ? 0.9
                                  : 1.5,
                        ),
                        child: s
                            ? widget.firstWidget!
                            : Scaffold(
                                body: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'images/foods.png',
                                        width: 300,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                  },
                ),
                darkTheme: ThemeData(
                  inputDecorationTheme: const InputDecorationTheme(
                      iconColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.white)),
                  textTheme: const TextTheme(
                    bodyText2: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    headline3: TextStyle(
                      color: Colors.grey,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    headline4: TextStyle(
                      color: Colors.pink,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle1: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    headline6: TextStyle(
                      color: Colors.grey,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    bodyText1: TextStyle(
                      color: Colors.grey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    headline5: TextStyle(
                      color: Colors.pink,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  scaffoldBackgroundColor: HexColor('333236'),
                  primarySwatch: Colors.pink,
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                          backgroundColor: Colors.pink),
                  appBarTheme: AppBarTheme(
                      titleSpacing: 20.0,
                      iconTheme: const IconThemeData(
                        color: Colors.pink,
                        size: 30.0,
                      ),
                      titleTextStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
// backwardsCompatibility: false,
                      backgroundColor: HexColor('333236'),
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor('333236'),
                          statusBarIconBrightness: Brightness.light)),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.pink,
                      elevation: 20.0,
                      backgroundColor: HexColor('333236'),
                      unselectedItemColor: Colors.grey),
                  drawerTheme:
                      DrawerThemeData(backgroundColor: HexColor('333236')),
                ),
                theme: ThemeData(
                  fontFamily: 'MyFont',
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.pink,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    bodyText2: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    headline3: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    headline4: TextStyle(
                      color: Colors.pink,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle1: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    headline5: TextStyle(
                        color: Colors.pink,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                  ),
                  primarySwatch: Colors.pink,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.pink[700]),
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                      titleSpacing: 20.0,
                      iconTheme: IconThemeData(
                        color: Colors.grey,
                        size: 30.0,
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.pink,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark)),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.pink,
                      elevation: 20.0),
                ),
              );
            },
            listener: (context, state) {}));
  }
}
