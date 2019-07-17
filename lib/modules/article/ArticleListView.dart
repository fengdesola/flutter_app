import 'package:flutter/material.dart';
import 'package:flutter_app/common/api/HttpApi.dart';
import 'package:flutter_app/common/bean/article/article_vo_entity.dart';
import 'package:flutter_app/core/base/state/CoreListState.dart';
import 'package:flutter_app/core/http/HttpResult.dart';
import 'package:flutter_app/core/http/HttpUtils.dart';
import 'package:flutter_app/modules/article/ArticleItemView.dart';

class ArticleListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArticleListViewState();
  }
}

class ArticleListViewState extends CoreListState<ArticleListView> {
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
      if (httpResult.isSuccess() && httpResult.isNotEmpty()) {
        List list = httpResult.data['datas'];
        List tempList = List<ArticleVoEntity>();
        if (list != null) {
          list.forEach((item) {
            tempList.add(ArticleVoEntity.fromJson(item));
          });
        }
        setSuitableData(tempList);
        showSuitableView();
      }
    }, errorCallback: (HttpResult httpResult) {
      showErrorView();
    });
  }

  @override
  onPullRefresh() {}
}
