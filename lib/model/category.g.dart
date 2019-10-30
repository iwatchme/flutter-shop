// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryListModel _$CategoryListModelFromJson(Map<String, dynamic> json) {
  return CategoryListModel(
      data: (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : CategoryBigModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CategoryListModelToJson(CategoryListModel instance) =>
    <String, dynamic>{'data': instance.data};

CategoryBigModel _$CategoryBigModelFromJson(Map<String, dynamic> json) {
  return CategoryBigModel(
      mallCategoryId: json['mallCategoryId'] as String,
      mallCategoryName: json['mallCategoryName'] as String,
      bxMallSubDto: (json['bxMallSubDto'] as List)
          ?.map((e) => e == null
              ? null
              : BxMallSubDto.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      image: json['image'] as String,
      comments: json['comments'] as String);
}

Map<String, dynamic> _$CategoryBigModelToJson(CategoryBigModel instance) =>
    <String, dynamic>{
      'mallCategoryId': instance.mallCategoryId,
      'mallCategoryName': instance.mallCategoryName,
      'bxMallSubDto': instance.bxMallSubDto,
      'image': instance.image,
      'comments': instance.comments
    };

BxMallSubDto _$BxMallSubDtoFromJson(Map<String, dynamic> json) {
  return BxMallSubDto(
      mallSubId: json['mallSubId'] as String,
      mallCategoryId: json['mallCategoryId'] as String,
      mallSubName: json['mallSubName'] as String,
      comments: json['comments'] as String);
}

Map<String, dynamic> _$BxMallSubDtoToJson(BxMallSubDto instance) =>
    <String, dynamic>{
      'mallSubId': instance.mallSubId,
      'mallCategoryId': instance.mallCategoryId,
      'mallSubName': instance.mallSubName,
      'comments': instance.comments
    };
