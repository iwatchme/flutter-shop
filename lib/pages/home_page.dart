import 'package:flutter/material.dart';
import 'package:shopdemo/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/service_url.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

int page = 1;
List<Map> hotGoodList = [];

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String content = "正在获取数据";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("主页"),
        ),
        body: FutureBuilder(
            future: request(servicePath['homePageContent'],
                formData: {'lon': '115.02932', 'lat': '35.76189'}),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                var result = json.decode(snapshot.data);
                List<Map> swiperDataList =
                    (result['data']['slides'] as List).cast();
                List<Map> navigatorList =
                    (result['data']['category'] as List).cast();
                navigatorList.removeRange(10, navigatorList.length);
                List<Map> recommendList =
                    (result['data']['recommend'] as List).cast();
                return EasyRefresh(
                    child: ListView(
                  children: <Widget>[
                    CustomSwiper(
                      data: swiperDataList,
                    ),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    RecommendList(
                      recommendItem: recommendList,
                    ),
                    HotProductList(),
                  ],
                ),
                loadMore: ()  async {
                  var formPage = {'page': page};
                  await request(servicePath['homePageHotContent'], formData: formPage).then((val) {
                    var data = json.decode(val);
                    List<Map> result = (data['data'] as List).cast();
                    setState(() {
                      hotGoodList.addAll(result);
                      page++;
                    });
                  });

                },
                  refreshFooter: ClassicsFooter(
                      key: GlobalKey<RefreshFooterState>(),
                      bgColor:Colors.white,
                      textColor: Colors.pink,
                      moreInfoColor: Colors.pink,
                      showMore: true,
                      noMoreText: '',
                      moreInfo: '加载中',
                      loadReadyText:'上拉加载....'
                  ),
                );
              } else {
                return Center(
                  child: Text("加载中"),
                );
              }
            }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TopNavigator extends StatelessWidget {
  List<Map> navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _CreateNavigatorItem(BuildContext context, Map item) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil.instance.setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: ScreenUtil.instance.setHeight(320),
        padding: EdgeInsets.all(3.0),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 5,
          children: navigatorList.map((item) {
            return _CreateNavigatorItem(context, item);
          }).toList(),
        ));
  }
}

class CustomSwiper extends StatelessWidget {
  List<Map> data;

  CustomSwiper({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      height: ScreenUtil.instance.setWidth(333),
      child: Swiper(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${data[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class RecommendList extends StatelessWidget {
  List<Map> recommendItem;

  RecommendList({Key key, this.recommendItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil.instance.setHeight(400),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _CreateRecommendListTitle(),
          _CreateRecommendHorizontalList(recommendItem)
        ],
      ),
    );
  }
}

Widget _CreateRecommendListTitle() {
  return Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
    child: Text(
      '商品推荐',
      style: TextStyle(color: Colors.pink),
    ),
  );
}

Widget _CreateRecommendHorizontalList(List<Map> items) {
  return Container(
    height: ScreenUtil.instance.setHeight(330),
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return _CreateRecommendItem(items[index]);
        }),
  );
}

Widget _CreateRecommendItem(Map item) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.all(8.0),
      height: ScreenUtil.instance.setHeight(330),
      width: ScreenUtil.instance.setWidth(250),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 0.5, color: Colors.black12))),
      child: Column(
        children: <Widget>[
          Image.network(item['image']),
          Text('${item['mallPrice']}'),
          Text(
            '${item['price']}',
            style: TextStyle(
                color: Colors.grey, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    ),
  );
}

class HotProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HotProductState();
  }
}

class _HotProductState extends State<HotProductList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(
      children: <Widget>[_CreateHotTitle(), _CreateHotList()],
    ));
  }

  void _getHotGoods() async {
    var formPage = {'page': page};
    await request(servicePath['homePageHotContent'], formData: formPage).then((val) {
      var data = json.decode(val);
      List<Map> result = (data['data'] as List).cast();
      setState(() {
        hotGoodList.addAll(result);
        page++;
      });
    });
  }

  @override
  void initState() {
    _getHotGoods();
  }
}

Widget _CreateHotTitle() {
  return Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
    child: Text('火爆专区'),
  );
}

Widget _CreateHotList() {
  if (hotGoodList.length != 0) {
    List<Widget> listWidget = hotGoodList.map((val) {
      return InkWell(
          onTap: () {
            print('点击了火爆商品');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(375),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ));
    }).toList();

    return Wrap(
      spacing: 2,
      children: listWidget,
    );
  } else {
    return Text(' ');
  }
}
