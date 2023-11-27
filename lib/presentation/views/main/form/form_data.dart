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
}
