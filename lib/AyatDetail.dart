import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tafseer_hafiz_abdusalam/Constants/Constants.dart';
import 'package:tafseer_hafiz_abdusalam/Database/DatabaseManager.dart';
import 'package:tafseer_hafiz_abdusalam/Models/AyatModel.dart';

// List View of Ayat detail
class AyatDetailList extends StatefulWidget {
  final int position;
  final bool isSurah;
  final String title;

  AyatDetailList(this.position, this.isSurah, this.title);

  @override
  _AyatDetailListState createState() =>
      new _AyatDetailListState(this.position, this.isSurah, this.title);
}

class _AyatDetailListState extends State<AyatDetailList>
    with TickerProviderStateMixin {
  DbManager dbManager = new DbManager();
  List<AyatModel> aayatList;

  final int position;
  final bool isSurah;
  final String title;

  _AyatDetailListState(this.position, this.isSurah, this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              snap: false,
              floating: true,
              title: Text(
              title,
              style: TextStyle(fontFamily: "NooreHuda"),
            ),
            centerTitle: true,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      makeListView(context, index),
                  childCount: aayatList.length)),
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();

    aayatList = [];
    dbManager.initializeDatabase();
    updateUi();
  }

  void updateUi() async {
    var list = [];
    if (isSurah) {
      list = await dbManager.getSurah(Constants.SURAT_ID, position + 1);
    } else {
      list = await dbManager.getSurah(Constants.PARAH, position + 1);
    }

    setState(() {
      aayatList = list;
    });
  }

  Widget makeListView(BuildContext context, int index) {
    AyatModel ayatModel = aayatList[index];
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        margin: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: MediaQuery.of(context).size.width,
              child: Text(
                ayatModel.ayat,
                style: TextStyle(fontFamily: "NooreHuda", fontSize: 18),
                textDirection: TextDirection.rtl,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade50,
              child: Text(
                ayatModel.translation,
                style:
                    TextStyle(fontFamily: "Jameel", fontSize: 18, height: 1.5),
                textDirection: TextDirection.rtl,
              ),
            ),
            ayatModel.tafseer.isEmpty
                ? SizedBox.shrink()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      ayatModel.tafseer ?? "",
                      style: TextStyle(
                          fontFamily: "Jameel", fontSize: 18, height: 1.5),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border(top: BorderSide(color: Colors.grey.shade300))),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "آیت نمبر: " + ayatModel.ayatNo,
                    style: TextStyle(
                        fontFamily: "Jameel",
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                  Text(
                    "پارہ نمبر: " + ayatModel.parhNo.toString(),
                    style: TextStyle(
                        fontFamily: "Jameel",
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

// View pager of Ayat detail
class AyatDetailViewPager extends StatefulWidget {
  final int position;
  final bool isSurah;
  final String title;

  AyatDetailViewPager({this.position, this.isSurah, this.title});

  @override
  _AyatDetailViewPagerState createState() =>
      _AyatDetailViewPagerState(this.position, this.isSurah, this.title);
}

class _AyatDetailViewPagerState extends State<AyatDetailViewPager>
    with SingleTickerProviderStateMixin {
  final int position;
  final bool isSurah;
  final String title;

  _AyatDetailViewPagerState(this.position, this.isSurah, this.title);

  TabController _tabController;
  List<Widget> widgetList = new List<Widget>();
  List<Tab> tabs = new List<Tab>();
  DbManager dbManager = new DbManager();
  List<AyatModel> aayatList = [];

  @override
  Widget build(BuildContext context) {
    return aayatList.isEmpty
        ? SizedBox.shrink()
        : Scaffold(
      backgroundColor: Colors.grey.shade300,
            body: new NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    title: new Text(
                      title,
                      style: TextStyle(fontFamily: "NooreHuda"),
                    ),
                    pinned: true,
                    floating: true,
                    centerTitle: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: new TabBar(
                      tabs: tabs,
                      labelStyle: TextStyle(
                        fontFamily: "Jameel",
                        fontSize: 18,
                      ),
                      isScrollable: true,
                      controller: _tabController,
                    ),
                  ),
                ];
              },
              body: new TabBarView(
                children: widgetList,
                controller: _tabController,
              ),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    updateUi();
  }

  void getWidget() {
    List<Widget> widgets = [];
    List<Tab> tabList = [];

    for (int i = 0; i < aayatList.length; i++) {
      widgets.add(makeList(i, aayatList[i]));

      tabList.add(new Tab(
        text: 'آیت ${i + 1}',
      ));
    }

    setState(() {
      widgetList.addAll(widgets);
      tabs.addAll(tabList);
    });
    _tabController = new TabController(vsync: this, length: aayatList.length);
  }

  void updateUi() async {
     var list = await dbManager.getSurah(Constants.SURAT_ID, position);

    setState(() {
      aayatList = list;
    });

    getWidget();
  }

  Widget makeList(int index, AyatModel model) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 4,),
          index == 0 && model.suratId != 9 && model.suratId != 1 ? Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text("بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "NooreHuda", fontSize: 22, height: 2),),
            ),
          ) : SizedBox.shrink(),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(model.ayat,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "NooreHuda", fontSize: 22, height: 2),),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(model.translation,
                  style: TextStyle(fontFamily: "Jameel", fontSize: 18, height: 2)),
            ),),
          Visibility(
            visible: model.tafseer.isNotEmpty,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(model.tafseer,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: "Jameel", fontSize: 18, height: 2)),
              ),),
          ),
        ],
      ),
    );
  }
}
