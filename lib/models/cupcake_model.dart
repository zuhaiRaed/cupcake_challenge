import 'package:cupcake_challenge/utils/assets.dart';
import 'package:cupcake_challenge/utils/style.dart';
import 'package:flutter/material.dart';

class CupCakeModel {
  final String? name;
  final String? image;
  final String? topping;
  final Color? backgroundColor;

  CupCakeModel({
    this.name,
    this.image,
    this.topping,
    this.backgroundColor,
  });

  static List<CupCakeModel> getCupCakeList() {
    final List<CupCakeModel> cupCakesList = [
      CupCakeModel(
        name: 'Blueberry',
        image: ImageAssets.blueberryCupcake,
        topping: ImageAssets.blueberryTopping,
        backgroundColor: Style.blueberry,
      ),
      CupCakeModel(
        name: 'Raspberry',
        image: ImageAssets.raspberryCupcake,
        topping: ImageAssets.raspberryTopping,
        backgroundColor: Style.raspberry,
      ),
      CupCakeModel(
        name: 'Strawberry',
        image: ImageAssets.strawberryCupcake,
        topping: ImageAssets.strawberryTopping,
        backgroundColor: Style.strawberry,
      ),
      CupCakeModel(
        name: 'Chocolate',
        image: ImageAssets.chocolateCupcake,
        topping: ImageAssets.chocolateTopping,
        backgroundColor: Style.chocolate,
      ),
    ];

    return cupCakesList;
  }
}
