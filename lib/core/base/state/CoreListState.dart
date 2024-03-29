import 'package:flutter/material.dart';
import 'package:flutter_app/core/widget/loadmore/LoadMore.dart' as LoadMore;

import 'CoreState.dart';

abstract class CoreListState<T extends StatefulWidget> extends CoreState<T> {
  static const int FIRST_PAGE = 0;
  int pageNo = FIRST_PAGE;
  int pageSize = 20;
  List _listData = List(); //列表数据,不包含头部数量，也不包含最后一个loadmore
  ScrollController scrollController = new ScrollController();

  bool _isLoading = false; //判断是否正在加载中，防止多次网络请求

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  bool _hasHeader = false; //是否有头部，有且只有一个widget

  bool _refreshEnable = false; //是否允许下拉刷新
  bool _loadMoreEnable = false; //是否允许加载更多
  bool _hasMoreData = false; //是否存在更多数据，只有在[loadMoreEnable]=true时才有效

  @override
  void initState() {
    super.initState();
    _initDefault();
    _addListener();
  }

  _initDefault() {
    this._refreshEnable = initRefreshEnable();
    this._loadMoreEnable = initLoadMoreEnable();
    this._hasHeader = initHasHeader();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildSelfList(context);
  }

  Widget buildSelfList(BuildContext context) {
    Widget widget = buildSelf(context);
    if (widget == null) {
      return buildListView();
    } else {
      return widget;
    }
  }

  void setRefreshEnable(bool enable) {
    setState(() {
      _refreshEnable = enable;
    });
  }

  void setLoadMoreEnable(bool enable) {
    setState(() {
      _loadMoreEnable = enable;
    });
  }

  void setData(List list) {
    _addData(list, false);
  }

  void addData(List list) {
    _addData(list, true);
  }

  /// [isMore] true添加，false重置
  void _addData(List list, bool isMore) {
    if (mounted) {
      setState(() {
        List listTemp = new List();

        if (isMore && _listData != null && _listData.isNotEmpty) {
          listTemp.addAll(_listData);
        }
        if (list != null && list.isNotEmpty) {
          listTemp.addAll(list);
        }
        _listData = listTemp;

        if (_loadMoreEnable) {
          _hasMoreData =
              (list != null && list.length == pageSize) ? true : false;
        }
      });
    }
  }

  void _addListener() {
    //添加滚动监听事件
    scrollController.addListener(() {
      double offset = scrollController.offset;
      var position = scrollController.position;
      double maxScroll = position.maxScrollExtent;
      double pixels = position.pixels;
//      print("maxScroll=${maxScroll},pixels=${pixels},hasMoreData=$hasMoreData");
      if (maxScroll == pixels &&
          _loadMoreEnable &&
          _hasMoreData &&
          !_isLoading) {
        //加载更多
        pageNo++;
        onRefresh();
      }
    });
  }

  ///创建整个listview，通用的可以返回[buildSimpleListView]
  Widget buildListView();

  Widget buildSimpleListView({Key key}) {
    Widget listView = ListView.builder(
      key: key,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(index);
      },
      itemCount:
          _listData.length + (_hasHeader ? 1 : 0) + (_loadMoreEnable ? 1 : 0),
      controller: scrollController,
    );
    if (_refreshEnable) {
      return RefreshIndicator(
        child: listView,
        onRefresh: _onRefresh,
      );
    } else {
      return listView;
    }
  }

  ///下拉刷新
  ///页面回到第一页,并自动刷新[onRefresh]
  Future _onRefresh() async {
    if (!_isLoading) {
      pageNo = FIRST_PAGE;
      onPullRefresh();
      onRefresh();
    }
  }

  Widget _buildListItem(int index) {
    if (_hasHeader && index == 0) {
      //header
      return buildHeaderWidget();
    } else if (_hasHeader) {
      //去掉头部占用的位置
      index--;
    }
//    print("index===========$index====${index >= listData.length}");

    if (_loadMoreEnable && index == _listData.length) {
      //load more
      return _hasMoreData
          ? LoadMore.LoadMoreIngView()
          : LoadMore.LoadMoreEndView();
    } else {
      var itemData = _listData[index];

      //item
      return buildListItem(itemData, index);
    }
  }

  Widget buildListItem(itemData, int index);

  bool isFirstPage() => pageNo == FIRST_PAGE;

  ///显示恰当的view
  showSuitableView() {
    if (isFirstPage() && isEmpty()) {
      showEmptyView();
    } else {
      restoreView();
    }
  }

  ///设置恰当的数据
  setSuitableData(List tempList) {
    if (isFirstPage()) {
      setData(tempList);
    } else {
      addData(tempList);
    }
  }

  @override
  bool isEmpty() => _listData == null || _listData.isEmpty;

  @override
  showEmptyView() {
    _isLoading = false;
    if (isEmpty()) {
      super.showEmptyView();
    } else {}
  }

  @override
  restoreView() {
    _isLoading = false;
    super.restoreView();
  }

  @override
  showErrorView() {
    _isLoading = false;
    if (isEmpty()) {
      super.showErrorView();
    } else {}
  }

  @override
  showLoadingView() {
    _isLoading = true;
    if (isEmpty()) {
      super.showLoadingView();
    } else {}
  }

  bool initRefreshEnable() {
    return false;
  }

  bool initLoadMoreEnable() {
    return false;
  }

  bool initHasHeader() {
    return false;
  }

  ///如果存在头部[_hasHeader]= true,则重写这个方法返回头部
  Widget buildHeaderWidget() {
    return SizedBox(
      width: 0,
      height: 0,
    );
  }

  ///下拉刷新
  ///提供方法，以便listview中其他widger需要刷新
  onPullRefresh();
}
