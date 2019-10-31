import 'package:flutter/material.dart';
import 'package:shopdemo/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = "4";

  getChildCategoryList(List list, String categoryId) {
    childCategoryList = list;
    childIndex = 0;
    this.categoryId = categoryId;
    notifyListeners();
  }

  changeChildIndex(index) {
    childIndex = index;
    notifyListeners();
  }
}
