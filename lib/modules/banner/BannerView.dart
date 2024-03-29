import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/api/HttpApi.dart';
import 'package:flutter_app/common/bean/banner/banner_entity.dart';
import 'package:flutter_app/common/event/BannerRefreshEvent.dart';
import 'package:flutter_app/core/base/state/CoreState.dart';
import 'package:flutter_app/core/eventbus/EventBus.dart';
import 'package:flutter_app/core/http/HttpResult.dart';
import 'package:flutter_app/core/http/HttpUtils.dart';
import 'package:flutter_app/core/utils/ObjectUtil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerView extends StatefulWidget {
  BannerView({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BannerViewState();
  }
}

class BannerViewState extends CoreState<BannerView> {
  //轮播图
  List<BannerEntity> bannerData;
  final double HIGH = 160;
  StreamSubscription _subscription;
  @override
  Widget build(BuildContext context) {
    Widget widget = super.build(context);
    if (widget == null) {
      widget = _initBannerView();
      return widget;
    } else {
      return widget;
    }
  }

  @override
  void initState() {
    super.initState();
    _getBanner();
    _subscription = eventBus.on<BannerRefreshEvent>().listen((event) {
      _getBanner();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  onRefresh() {
    _getBanner();
  }

  void _getBanner() {
    showLoadingView();
    HttpUtils.post<BannerEntity>(HttpApi.BANNER, (HttpResult httpResult) {
      if (httpResult.isSuccess() && httpResult.isNotEmpty()) {
        List bannerList = httpResult.data;
//        List bannerList = List<BannerEntity>();
//        if (list != null) {
//          list.forEach((item) {
//            bannerList.add(BannerEntity.fromJson(item));
//          });
//        }
        setState(() {
          bannerData = bannerList.cast<BannerEntity>();
        });
        restoreView();
      }
    });
  }

  Widget _initBannerView() {
    Swiper swiper = Swiper(
      scrollDirection: Axis.horizontal, //滚动方向
      loop: true,
      autoplay: true,
      itemHeight: HIGH,
      containerHeight: HIGH,
      itemCount: ObjectUtil.intF(bannerData?.length),
      index: 0,
      pagination: new SwiperPagination(),
//      control: new SwiperControl(),
      viewportFraction: 0.8,
      scale: 0.9,
      itemBuilder: (BuildContext context, int index) {
        BannerEntity bannerEntity = bannerData[index];
        return Image.network(
          bannerEntity.imagePath,
          fit: BoxFit.fill,
        );
      },
    );
    Container container = Container(
      child: swiper,
      height: HIGH,
    );

    return container;
  }
}
