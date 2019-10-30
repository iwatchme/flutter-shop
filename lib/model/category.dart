import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryListModel {
  List<CategoryBigModel> data;

  CategoryListModel({this.data});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListModelToJson(this);
}

@JsonSerializable()
class CategoryBigModel {
  String mallCategoryId; //类别编号
  String mallCategoryName; //类别名称
  List<BxMallSubDto> bxMallSubDto; //小类列表
  String image; //类别图片
  String comments;

  CategoryBigModel(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.image,
      this.comments});

  factory CategoryBigModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryBigModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryBigModelToJson(this);
//列表描述
}

@JsonSerializable()
class BxMallSubDto {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  factory BxMallSubDto.fromJson(Map<String, dynamic> json) =>
      _$BxMallSubDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BxMallSubDtoToJson(this);

  BxMallSubDto(
      {this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});
}
