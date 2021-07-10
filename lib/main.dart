import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_layout/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_layout/layout/shop_app/cubit/shop_states.dart';
import 'package:shop_layout/layout/shop_app/shop_layout.dart';
import 'package:shop_layout/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_layout/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_layout/shared/bloc_observer.dart';
import 'package:shop_layout/shared/network/local/cache_helper.dart';
import 'package:shop_layout/shared/network/remote/dio_helper.dart';
import 'package:shop_layout/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  //bool isDark = CacheHelper.getData(key: 'isDark');

  Widget? widget;
bool ? onBoarding;
String? token;
  onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  } else
  {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(

    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget
{

   Widget? startWidget;

  MyApp({

    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
             ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}