import 'package:flutter/material.dart';
import 'package:shopdemo/model/category.dart';


class ChildCategory with ChangeNotifier {

  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;

  getChildCategoryList(List list) {
    childCategoryList =  list;
    notifyListeners();
  }

  changeChildIndex(index){
    childIndex=index;
    notifyListeners();
  }

}