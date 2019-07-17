import 'package:flutter_app/common/bean/article/article_vo_entity.dart';
import 'package:flutter_app/common/bean/banner/banner_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticleVoEntity") {
      return ArticleVoEntity.fromJson(json) as T;
    } else if (T.toString() == "BannerEntity") {
      return BannerEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}