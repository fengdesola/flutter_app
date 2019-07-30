import 'package:flutter/material.dart';
import 'package:flutter_app/common/res/StringRes.dart';
import 'package:flutter_app/modules/article/ArticleListView.dart';

class ArticleCollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringRes.my_collection),
      ),
      body: ArticleListView(
        isCollection: true,
      ),
    );
  }
}
