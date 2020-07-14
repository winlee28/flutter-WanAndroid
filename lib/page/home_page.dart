import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_wanandroid/dao/home_article_dao.dart';
import 'package:my_wanandroid/dao/home_banner_dao.dart';
import 'package:my_wanandroid/model/article_model.dart';
import 'package:my_wanandroid/model/home_banner_model.dart';
import 'package:my_wanandroid/widget/article_card.dart';
import 'package:my_wanandroid/widget/home_drawer.dart';
import 'package:my_wanandroid/widget/webview.dart';
import 'package:toast/toast.dart';

const double SCROLL_PIXELS_OFFSET = 500;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;

  List<BannerData> bannerList = [];
  List<ArticleItem> articleData = [];

  int offset = 0;
  double scrollPixels = 0;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _loadBannerData();
    _loadArticle();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        offset++;
        _loadArticle();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '首页',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          leading: Builder(
              builder: (context) => GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Icon(
                      Icons.dehaze,
                      color: Colors.white,
                    ),
                  )),
        ),
        floatingActionButton: scrollPixels > SCROLL_PIXELS_OFFSET
            ? FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(0,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.ease);
                },
                backgroundColor: Colors.lightBlue,
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
              )
            : null,
        drawer: HomeDrawer(),
        body: articleData.length > 0
            ? NotificationListener(
                onNotification: (onNotification) {
                  if (onNotification is ScrollUpdateNotification) {
                    if (onNotification.depth == 0) {
                      //防止banner滚动监听
                      setState(() {
                        scrollPixels = onNotification.metrics.pixels;
                      });
                    }
                  }
                },
                child: RefreshIndicator(
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        controller: _scrollController,
                        itemCount: articleData.length,
                        itemBuilder: (context, index) {
                          return _homePageItem(index);
                        }),
                    onRefresh: _onRefresh))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Future<Null> _onRefresh() async {
    offset = 0;
    HomeArticleDao.fetch(offset).then((model) {
      setState(() {
        articleData = model.data.itemList;
      });
    }).catchError((error) {
      print(error.toString());
    });
    return null;
  }

  void _loadBannerData() {
    HomeBannerDao.fetch().then((model) {
      setState(() {
        bannerList = model.data;
      });
    }).catchError((error) {
      Toast.show(error.toString(), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    });
  }

  _banner() {
    return bannerList.length > 0
        ? Container(
            height: 180,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebView(
                              url: bannerList[index].url,
                              title: bannerList[index].title,
                            )));
                  },
                  child: new Image.network(
                    bannerList[index].imagePath,
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: bannerList.length,
              autoplay: true,
              pagination: new SwiperPagination(),
            ),
          )
        : Container();
  }

  void _loadArticle() {
    HomeArticleDao.fetch(offset).then((model) {
      setState(() {
        if (offset == 0) {
          articleData = model.data.itemList;
        } else {
          articleData.addAll(model.data.itemList);
        }
      });
    }).catchError((error) {
      Toast.show(error.toString(), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    });
  }

  _homePageItem(int index) {
    return index == 0
        ? _banner()
        : ArticleCard(
            articleItem: articleData[index],
          );
  }

}
