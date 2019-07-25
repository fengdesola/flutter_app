import 'package:flutter/material.dart';
import 'package:flutter_app/common/api/HttpApi.dart';
import 'package:flutter_app/common/bean/article/item_vo_entity.dart';
import 'package:flutter_app/core/base/state/CoreListState.dart';
import 'package:flutter_app/core/http/HttpResult.dart';
import 'package:flutter_app/core/http/HttpUtils.dart';
import 'package:flutter_app/modules/article/ItemItemView.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FindPageState();
  }
}

class FindPageState extends CoreListState<FindPage> {
  @override
  void initState() {
    super.initState();
    _taskData();
  }

  @override
  Widget buildListItem(itemData, int index) {
    return ItemItemView(itemData);
  }

  @override
  Widget buildListView() {
    return buildSimpleListView();
  }

  @override
  onPullRefresh() {
    return null;
  }

  @override
  onRefresh() {
    _taskData();
  }

  bool initRefreshEnable() {
    return true;
  }

  void _taskData() {
    showLoadingView();
    String url = HttpApi.TREE;
    HttpUtils.get<ItemVoEntity>(url, (HttpResult httpResult) {
      if (httpResult.isNotEmpty()) {
        setSuitableData(httpResult.data);
        showSuitableView();
      } else {
        showEmptyView();
      }
    }, errorCallback: (HttpResult httpResult) {
      showErrorView();
    });
  }
}
