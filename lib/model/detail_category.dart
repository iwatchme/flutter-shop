import 'package:json_annotation/json_annotation.dart';

part 'detail_category.g.dart';


@JsonSerializable()
class CategoryGoodsListModel {
  List<CategoryListData> data;

  CategoryGoodsListModel({this.data});

  factory CategoryGoodsListModel.fromJson(Map<String, dynamic> json) => _$CategoryGoodsListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryGoodsListModelToJson(this);
}


@JsonSerializable()
class CategoryListData {
  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  CategoryListData({this.image,
    this.oriPrice,
    this.presentPrice,
    this.goodsName,
    this.goodsId});

  factory CategoryListData.fromJson(Map<String, dynamic> json) => _$CategoryListDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListDataToJson(this);

}