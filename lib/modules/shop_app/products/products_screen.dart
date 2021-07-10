import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_layout/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_layout/layout/shop_app/cubit/shop_states.dart';
import 'package:shop_layout/models/shop_app/home_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).homeModel != null
            ? builderWidget(ShopCubit.get(context).homeModel!)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget builderWidget(HomeModel model) => Column(
        children: [
          CarouselSlider(
            items: model.data?.banners
                ?.map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      );
}
