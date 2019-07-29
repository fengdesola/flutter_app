import 'package:flutter/material.dart';
import 'package:flutter_app/common/api/HttpApi.dart';
import 'package:flutter_app/common/bean/article/article_vo_entity.dart';
import 'package:flutter_app/common/cache/AccountData.dart';
import 'package:flutter_app/common/res/ColorRes.dart';
import 'package:flutter_app/common/res/DimenRes.dart';
import 'package:flutter_app/common/res/StringRes.dart';
import 'package:flutter_app/common/res/TextStyleRes.dart';
import 'package:flutter_app/core/base/CoreWebPage.dart';
import 'package:flutter_app/core/http/HttpResult.dart';
import 'package:flutter_app/core/http/HttpUtils.dart';
import 'package:flutter_app/core/utils/AppNavigator.dart';
import 'package:flutter_app/core/utils/ObjectUtil.dart';
import 'package:flutter_app/core/utils/StringUtil.dart';
import 'package:flutter_app/core/utils/ToastUtil.dart';
import 'package:flutter_app/modules/account/LoginPage.dart';

/**
 * 文章 item view
 */
class ArticleItemView extends StatefulWidget {
  ArticleVoEntity itemVo;
  ArticleItemView(this.itemVo);
  @override
  State<StatefulWidget> createState() {
    return ArticleItemState();
  }
}

class ArticleItemState extends State<ArticleItemView> {
  @override
  Widget build(BuildContext context) {
    var itemVo = widget.itemVo;
    Row row1 = _initRow1(itemVo);
    Row content = _initRowContent(itemVo);
    Row row2 = _initRow2(itemVo);
    Column column = _initColumn(row1, content, row2);
    return Card(
      elevation: DimenRes.dp_4,
//      margin: EdgeInsets.fromLTRB(
//          DimenRes.dp_8, DimenRes.dp_0, DimenRes.dp_8, DimenRes.dp_0),
      child: InkWell(
        child: column,
        onTap: () => _onItemClick(itemVo),
      ),
    );
  }

  Row _initRow1(ArticleVoEntity itemVo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            StringRes.author + StringUtil.notNull(itemVo.author),
            style: TextStyleRes.normalMain,
          ),
        ),
        IconButton(
          icon: Icon(ObjectUtil.boolF(itemVo.collect)
              ? Icons.favorite
              : Icons.favorite_border),
          onPressed: () {
            _collectOnPressed(itemVo);
          },
        ),
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            _shareOnPressed(itemVo);
          },
        )
      ],
    );
  }

  Row _initRowContent(ArticleVoEntity itemVo) {
    Row content = Row(
      children: <Widget>[
        Expanded(
          child: Text(
            itemVo.title,
            style: TextStyleRes.largeMain,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
    return content;
  }

  Row _initRow2(ArticleVoEntity itemVo) {
    Row row = Row(
      children: <Widget>[
        Text(
          '分类：',
          style: TextStyleRes.smallMain,
        ),
        Expanded(
          child: Text(
            itemVo.getChapter(),
            softWrap: true,
            style: TextStyleRes.small(ColorRes.text_blue),
            textAlign: TextAlign.left,
            maxLines: 1,
          ),
        ),
        Text(itemVo.getDate())
      ],
    );
    return row;
  }

  void _collectOnPressed(ArticleVoEntity itemVo) {
    AccountData.isLogin().then((isLogin) {
      if (isLogin) {
        String url = ObjectUtil.boolF(itemVo.collect)
            ? HttpApi.UN_COLLECT_ORIGIN
            : HttpApi.COLLECT;
        url += '${itemVo.id}/json';
        HttpUtils.post(url, (HttpResult httpResult) {
          if (httpResult.isSuccess()) {
            setState(() {
              itemVo.collect = !ObjectUtil.boolF(itemVo.collect);
            });
          }
        }, errorCallback: (HttpResult httpResult) {
          if (httpResult.code == -1001) {
            toLoginPage(itemVo);
          }
        });
      } else {
        toLoginPage(itemVo);
      }
    });
  }

  void toLoginPage(ArticleVoEntity itemVo) {
    AppNavigator.pushResult(context, LoginPage(), (result) {
      if (result is bool && ObjectUtil.boolF(result)) {
        _collectOnPressed(itemVo);
      }
    });
  }

  void _shareOnPressed(ArticleVoEntity itemVo) {
    ToastUtil.toast("share==" + itemVo.desc);
  }

  Column _initColumn(Row row1, Row content, Row row2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(DimenRes.dp_8),
          child: row1,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              DimenRes.dp_8, DimenRes.dp_0, DimenRes.dp_8, DimenRes.dp_0),
          child: content,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              DimenRes.dp_8, DimenRes.dp_8, DimenRes.dp_8, DimenRes.dp_8),
          child: row2,
        ),
      ],
    );
  }

  _onItemClick(ArticleVoEntity itemVo) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CoreWebPage(
        title: itemVo.title,
        url: itemVo.link,
      );
    }));
  }
}
