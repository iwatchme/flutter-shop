import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../config/service_url.dart';
import '../model/category.dart';
import '../model/detail_category.dart';
import '../provider/category_goods_list.dart';
import '../provider/child_category.dart';
import '../service/service_method.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryState();
  }
}

class _CategoryState extends State<CategoryPage> {
  var content = "category";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("分类"),
        ),
        body: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[RightCategoryNav(), CategoryGoodList()],
            )
          ],
        ));
  }

  @override
  void initState() {}
}

class LeftCategoryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeftCategoryState();
  }
}

class _LeftCategoryState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0; //索引

  void _getGoodList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': "",
      'page': 1
    };
    await request(servicePath['getMallGoods'], formData: data).then((val) {
      var data = json.decode(val);
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(categoryGoodsListModel.data);
    });
  }

  Widget _leftInkWel(int index, BuildContext context) {
    bool isClick = listIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childCategory = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context)
            .getChildCategoryList(childCategory);
        _getGoodList(categoryId: list[index].mallCategoryId);
      },
      child: Container(
        height: ScreenUtil.instance.setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Colors.black26 : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil.instance.setSp(28)),
        ),
      ),
    );
  }

  void _GetCategory() async {
    await request(servicePath['getCategory']).then((value) {
      print("frank: $value");
      CategoryListModel listModel =
          CategoryListModel.fromJson(json.decode(value));
      setState(() {
        list = listModel.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategoryList(list[0].bxMallSubDto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil.instance.setWidth(180),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _leftInkWel(index, context);
          },
        ));
  }

  @override
  void initState() {
    _GetCategory();
    _getGoodList();
  }
}

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Provide<ChildCategory>(
      builder:
          (BuildContext context, Widget child, ChildCategory childCategory) {
        return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(
                    childCategory.childCategoryList[index], index);
              },
            ));
      },
    ));
  }

  Widget _rightInkWell(BxMallSubDto item, int index) {
    bool isCheck = false;
    isCheck = (index == Provide.value<ChildCategory>(context).childIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context).changeChildIndex(index);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isCheck ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}

class CategoryGoodList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryGoodListState();
  }
}

class _CategoryGoodListState extends State<CategoryGoodList> {
  List list;

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder:
          (BuildContext context, Widget child, CategoryGoodsListProvide data) {
        return Expanded(
          child: Container(
              width: ScreenUtil().setWidth(570),
              child: ListView.builder(
                itemCount: data.goodsList.length,
                itemBuilder: (context, index) {
                  return _ListWidget(data.goodsList, index);
                },
              )),
        );
      },
    );
  }

  Widget _goodsImage(List newList, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsPrice(List newList, int index) {
    return Container(
        margin: EdgeInsets.only(top: 20.0),
        width: ScreenUtil().setWidth(370),
        child: Row(children: <Widget>[
          Text(
            '价格:￥${newList[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${newList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ]));
  }

  Widget _ListWidget(List newList, int index) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12))),
          child: Row(
            children: <Widget>[
              _goodsImage(newList, index),
              Column(
                children: <Widget>[
                  _goodsName(newList, index),
                  _goodsPrice(newList, index)
                ],
              )
            ],
          ),
        ));
  }

  Widget _goodsName(List newList, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }
}
