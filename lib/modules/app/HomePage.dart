import 'package:flutter/material.dart';
import 'package:flutter_app/common/api/HttpApi.dart';
import 'package:flutter_app/common/bean/article/article_vo_entity.dart';
import 'package:flutter_app/core/base/state/CoreListState.dart';
import 'package:flutter_app/core/http/HttpResult.dart';
import 'package:flutter_app/core/http/HttpUtils.dart';
import 'package:flutter_app/core/http/Parser.dart';
import 'package:flutter_app/modules/article/ArticleItemView.dart';
import 'package:flutter_app/modules/banner/BannerView.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends CoreListState<HomePage> {
  BannerView _bannerView;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget buildListItem(itemData, int index) {
    return ArticleItemView(itemData);
  }

  @override
  Widget buildListView() {
    return buildSimpleListView();
  }

  @override
  onRefresh() {
    _getData();
  }

  void _getData() {
    showLoadingView();
    String url = HttpApi.ARTICLE_LIST;
    url += "$pageNo/json";
    HttpUtils.get(url, (HttpResult httpResult) {
      if (httpResult.isNotEmpty()) {
//        List list = httpResult.data['datas'];
//        List tempList = List<ArticleVoEntity>();
//        if (list != null) {
//          list.forEach((item) {
//            tempList.add(ArticleVoEntity.fromJson(item));
//          });
//        }

//        List<ArticleVoEntity> tempList = parser.parserInstance
//            .parser<ArticleVoEntity>(httpResult.data['datas']);
//        List<ArticleVoEntity> tempList =
//            await parser.parse<ArticleVoEntity>(httpResult.data['datas']);
        parse<ArticleVoEntity>(httpResult.data['datas']).then((value) {
          setSuitableData(value);
          showSuitableView();
        });
      } else {
        showEmptyView();
      }
    }, errorCallback: (HttpResult httpResult) {
      showErrorView();
    });
  }

  @override
  bool initRefreshEnable() {
    return true;
  }

  @override
  bool initLoadMoreEnable() {
    return true;
  }

  @override
  bool initHasHeader() {
    return true;
  }

  @override
  Widget buildHeaderWidget() {
    _bannerView = BannerView();
    return _bannerView;
  }

  @override
  onPullRefresh() {
    _bannerView.onRefresh();
  }
}
