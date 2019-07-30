// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/CoreConstant.dart';

import 'core/http/http.dart';
import 'modules/app/MainTabPage.dart';

void main() {
  CoreConstant.init(true, "https://www.wanandroid.com/");
  HttpDio.init();
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  final GlobalKey navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    CoreConstant.init(true, "https://www.wanandroid.com/");

    print(''' 
    
     へ　　　　　／|
　　/＼7　　　 ∠＿/
　 /　│　　 ／　／
　│　Z ＿,＜　／　　 /`ヽ
　│　　　　　ヽ　　 /　　〉
　 Y　　　　　`　   /　　/
　ｲ●　､　●　　⊂⊃〈　　/
　()　 へ　　　　|　＼〈
　　>ｰ ､_　 ィ　 │ ／／
　 / へ　　 /　ﾉ＜| ＼＼
　 ヽ_ﾉ　　(_／　 │／／
　　7　　　　　　　|／
　　＞―r￣￣`ｰ―＿    ''');

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: _title,
//      theme: new ThemeData(
//        primaryColor: Colors.white,
//      ),
      home: MainTabPage(),
      //debug模式下是否显示材质网格
//      debugShowMaterialGrid: CoreConstant.debug,
      //当为true时应用程序顶部覆盖一层GPU和UI曲线图，可即时查看当前流畅度情况
//      showPerformanceOverlay: CoreConstant.debug,
      //当为true时，打开光栅缓存图像的棋盘格
//      checkerboardRasterCacheImages: CoreConstant.debug,
      //当为true时，打开呈现到屏幕位图的层的棋盘格
//      checkerboardOffscreenLayers: CoreConstant.debug,
      //当为true时，打开Widget边框，类似Android开发者模式中显示布局边界
//      showSemanticsDebugger: CoreConstant.debug,
      //当为true时，在debug模式下显示右上角的debug字样的横幅，false即为不显示
      debugShowCheckedModeBanner: CoreConstant.debug,
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    var randomWords = new RandomWords();
    return Scaffold(
      appBar: AppBar(
        title: Text('Ready, Set, Shop! xxx'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // Implement navigation to shopping cart page here...
              print('Shopping cart opened.');
            },
          ),
        ],
      ),
      body: new Center(
//        child: new Text(wordPair.asPascalCase),
        child: randomWords,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }

  void test(String xx, [String test = '123']) {}
  void test2({String xx, String ex}) {}
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            iconSize: 16,
            onPressed: () {
              _pushSaved();
            },
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力。
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();

          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
          if (index >= _suggestions.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  void _pushSaved() {
    //添加MaterialPageRoute及其builder。 现在，添加生成ListTile行的代码。ListTile的divideTiles()方法在每个ListTile之间添加1像素的分割线。 该 divided 变量持有最终的列表项。
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

class Test {
  String a;
  Test(String a) : this.a = a;
  Test.newTest(String a) {}
  Test.newInt(int a) : assert(a > 0) {}

  void test() {}
}
