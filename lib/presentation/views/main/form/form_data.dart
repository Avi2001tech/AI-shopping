import 'package:flutter/material.dart';
import 'package:eshop/presentation/views/main/form/form_view.dart';

class FormData {
  String occasion;
  String bodyHeight;
  ProductGender? gender;
  String? skinTone;
  String? waistSize;
  String? bodyShape;

  FormData({
    required this.occasion,
    required this.bodyHeight,
    this.gender,
    this.skinTone,
    this.waistSize,
    this.bodyShape,
  });

  String toParagraph() {
    return "${gender?.name ?? 'Gender'} $occasion dress recommendations for someone with a body height of $bodyHeight cm, $skinTone skin and a $bodyShape body with a waist of $waistSize.Please give in 2-3 lines";
  }
}
