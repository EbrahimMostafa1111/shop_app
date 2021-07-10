import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_layout/layout/shop_app/cubit/shop_states.dart';
import 'package:shop_layout/models/shop_app/home_model.dart';
import 'package:shop_layout/modules/shop_app/cateogries/categories_screen.dart';
import 'package:shop_layout/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_layout/modules/shop_app/products/products_screen.dart';
import 'package:shop_layout/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_layout/shared/components/constants.dart';
import 'package:shop_layout/shared/network/end_points.dart';
import 'package:shop_layout/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
   ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}
