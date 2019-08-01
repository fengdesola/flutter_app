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
  bool isCollection;
  Key key;

  ArticleListView({this.itemVoEntity, this.isCollection = false}) {
    if (itemVoEntity != null) {
      key = PageStorageKey<String>(itemVoEntity.name);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return ArticleListViewState();
  }
}

class ArticleListViewState extends CoreListState<ArticleListView>
    with AutomaticKeepAliveClientMixin {
  @override

  ///with AutomaticKeepAliveClientMixin 实现widget在不显示之后也不会被销毁仍然保存在内存中，所以慎重使用这个方法
  ///配合DefaultTabController的TabBarView，实现切换后再切回来，不刷新页面效果
  ///但是AutomaticKeepAliveClientMixin 必须调用 build方法，而且with里的方法会覆盖extends里的同名方法
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildSelfList(context);
  }

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
    return buildSimpleListView(key: widget.key);
  }

  @override
  onRefresh() {
    _getData();
  }

  void _getData() {
    showLoadingView();
    String url =
        widget.isCollection ? HttpApi.COLLECT_LIST : HttpApi.ARTICLE_LIST;
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
    },
        params: widget.itemVoEntity == null
            ? null
            : {"cid": widget.itemVoEntity?.id?.toString()});
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
