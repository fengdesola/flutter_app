import 'package:flutter/material.dart';
import 'package:flutter_app/common/api/HttpApi.dart';
import 'package:flutter_app/common/bean/article/article_vo_entity.dart';
import 'package:flutter_app/common/bean/article/item_vo_entity.dart';
import 'package:flutter_app/core/base/state/CoreListState.dart';
import 'package:flutter_app/core/http/HttpResult.dart';
import 'package:flutter_app/core/http/HttpUtils.dart';
import 'package:flutter_app/core/http/Parser.dart';
import 'package:flutter_app/modules/article/ArticleItemView.dart';

class ArticleListView extends StatefulWidget {
  ItemVoEntity itemVoEntity;

  ArticleListView(this.itemVoEntity);

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
      if (httpResult.isNotEmpty()) {
        parse<ArticleVoEntity>(httpResult.data['datas']).then((value) {
          setSuitableData(value);
          showSuitableView();
        });
      } else {
        showEmptyView();
      }
    }, errorCallback: (HttpResult httpResult) {
      showErrorView();
    }, params: {"cid": widget.itemVoEntity?.id?.toString()});
  }

  @override
  bool initLoadMoreEnable() {
    return true;
  }

  @override
  bool initRefreshEnable() {
    return true;
  }

  @override
  onPullRefresh() {}
}
