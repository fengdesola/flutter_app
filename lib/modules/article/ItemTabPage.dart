import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/article/item_vo_entity.dart';
import 'package:flutter_app/common/res/ColorRes.dart';
import 'package:flutter_app/core/base/state/CoreState.dart';
import 'package:flutter_app/modules/article/ArticleListView.dart';

class ItemTabPage extends StatefulWidget {
  ItemVoEntity itemVoEntity;

  ItemTabPage(this.itemVoEntity);

  @override
  State<StatefulWidget> createState() {
    return ItemTabState();
  }
}

class ItemTabState extends CoreState<ItemTabPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    //创建TabController对象
    tabController = new TabController(
        length: widget.itemVoEntity?.children?.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemVoEntity?.name),
      ),
      body: DefaultTabController(
        length: widget.itemVoEntity?.children?.length,
        child: Scaffold(
          appBar: TabBar(
            tabs: _initTabs(widget.itemVoEntity),
            controller: tabController,
            isScrollable: true,
//            indicatorColor: ColorRes.text_main,
            labelColor: ColorRes.text_main,
            unselectedLabelColor: ColorRes.text_sub,
//  style 没有效果？
//            labelStyle: TextStyleRes.normalMain,
//            unselectedLabelStyle: TextStyleRes.normalSub,
          ),
          body: TabBarView(
            controller: tabController,
            children: widget.itemVoEntity.children.map((ItemVoEntity item) {
              return ArticleListView(itemVoEntity: item);
            }).toList(),
          ),
        ),
      ),
    );
  }

  _initTabs(ItemVoEntity itemVoEntity) {
    return itemVoEntity?.children?.map((ItemVoEntity item) {
      return Tab(
        text: item.name,
      );
    })?.toList();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  onRefresh() {
    return null;
  }
}
