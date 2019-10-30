import 'package:flutter/material.dart';
import 'package:shopdemo/pages/index_page.dart';
import 'provider/child_category.dart';
import 'package:provide/provide.dart';
import 'provider/category_goods_list.dart';

void main() {
  var childCategory = ChildCategory();
  var categoryGoodsList = CategoryGoodsListProvide();
  var providers = Providers();
  providers..provide(Provider<ChildCategory>.value(childCategory))
           ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "shop",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.red),
        home: IndexPage(),
      ),
    );
  }
}
