import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/article/item_vo_entity.dart';
import 'package:flutter_app/common/res/ColorRes.dart';
import 'package:flutter_app/common/res/DimenRes.dart';
import 'package:flutter_app/common/res/TextStyleRes.dart';
import 'package:flutter_app/core/utils/AppNavigator.dart';
import 'package:flutter_app/modules/article/ItemTabPage.dart';

class ItemItemView extends StatefulWidget {
  ItemVoEntity itemVo;

  ItemItemView(this.itemVo);

  @override
  State<StatefulWidget> createState() {
    return ItemItemViewState();
  }
}

class ItemItemViewState extends State<ItemItemView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: DimenRes.dp_4,
//      margin: EdgeInsets.fromLTRB(
//          DimenRes.dp_8, DimenRes.dp_0, DimenRes.dp_8, DimenRes.dp_0),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(DimenRes.dp_16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Text(
                widget.itemVo.name,
                style: TextStyleRes.largeMain,
              )),
              Text(
                "${widget.itemVo.children.length}分类",
                style: TextStyleRes.normal(ColorRes.text_red),
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
        onTap: () => _onItemClick(widget.itemVo),
      ),
    );
  }

  _onItemClick(ItemVoEntity itemVo) {
    AppNavigator.push(context, ItemTabPage(itemVo));
  }
}
