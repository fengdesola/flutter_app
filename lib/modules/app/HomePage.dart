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
  GlobalKey<BannerViewState> _bannerKey = GlobalKey<BannerViewState>();

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
    return BannerView(key: _bannerKey);
  }

  @override
  onPullRefresh() {
    ///2种方法调用其他widget里state的方法
    ///1，通过eventBus发送事件
    ///2，通过维护GlobalKey来调用key.currentState直接调用该state里的方法
//    eventBus.fire(BannerRefreshEvent());
    _bannerKey.currentState.onRefresh();
  }
}
