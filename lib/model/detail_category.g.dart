// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryGoodsListModel _$CategoryGoodsListModelFromJson(
    Map<String, dynamic> json) {
  return CategoryGoodsListModel(
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : CategoryListData.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CategoryGoodsListModelToJson(
        CategoryGoodsListModel instance) =>
    <String, dynamic>{'data': instance.data};

CategoryListData _$CategoryListDataFromJson(Map<String, dynamic> json) {
  return CategoryListData(
      image: json['image'] as String,
      oriPrice: (json['oriPrice'] as num)?.toDouble(),
      presentPrice: (json['presentPrice'] as num)?.toDouble(),
      goodsName: json['goodsName'] as String,
      goodsId: json['goodsId'] as String);
}

Map<String, dynamic> _$CategoryListDataToJson(CategoryListData instance) =>
    <String, dynamic>{
      'image': instance.image,
      'oriPrice': instance.oriPrice,
      'presentPrice': instance.presentPrice,
      'goodsName': instance.goodsName,
      'goodsId': instance.goodsId
    };
