import 'package:flutter_app/common/bean/account/login_user_entity.dart';
import 'package:flutter_app/common/bean/article/article_vo_entity.dart';
import 'package:flutter_app/common/bean/article/item_vo_entity.dart';
import 'package:flutter_app/common/bean/banner/banner_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticleVoEntity") {
      return ArticleVoEntity.fromJson(json) as T;
    } else if (T.toString() == "ItemVoEntity") {
      return ItemVoEntity.fromJson(json) as T;
    } else if (T.toString() == "BannerEntity") {
      return BannerEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginUserEntity") {
      return LoginUserEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}

class EntityFactoryParse {
  static generateObj(Map<String, dynamic> json, String clazz) {
    if (1 == 0) {
      return null;
    } else if (clazz == "ArticleVoEntity") {
      return ArticleVoEntity.fromJson(json);
    } else if (clazz == "ItemVoEntity") {
      return ItemVoEntity.fromJson(json);
    } else if (clazz == "BannerEntity") {
      return BannerEntity.fromJson(json);
    } else if (clazz == "LoginUserEntity") {
      return LoginUserEntity.fromJson(json);
    } else {
      return null;
    }
  }
}
