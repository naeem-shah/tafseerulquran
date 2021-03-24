import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/AyatDetail.dart';
import 'package:tafseer_hafiz_abdusalam/QuranData/QuranInfo.dart';
import 'package:tafseer_hafiz_abdusalam/Search.dart';
import 'package:tafseer_hafiz_abdusalam/ui/pages/home.dart';

import 'Database/DatabaseManager.dart';

void main() => runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: const Color(0xff9E8D3F),
        primarySwatch: MaterialColor(0xFF40519F, {
          50:Color.fromRGBO(64,81,159, .1),
          100:Color.fromRGBO(64,81,159, .2),
          200:Color.fromRGBO(64,81,159, .3),
          300:Color.fromRGBO(64,81,159, .4),
          400:Color.fromRGBO(64,81,159, .5),
          500:Color.fromRGBO(64,81,159, .6),
          600:Color.fromRGBO(64,81,159, .7),
          700:Color.fromRGBO(64,81,159, .8),
          800:Color.fromRGBO(64,81,159, .9),
          900:Color.fromRGBO(64,81,159, 1),
        }),
      ),
      // builder: (context, child) {
      //   return Directionality(
      //     // textDirection: TextDirection.rtl,
      //     child: child,
      //   );
      // },
      home: HomePage(),
    )
);

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  final nameController = TextEditingController();

  DbManager dbManager = new DbManager();
  List<Info> quranInfo = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: Text('تفسیر القرآن الکریم', style: TextStyle(
          fontFamily: 'Jameel',
          fontWeight: FontWeight.w500
        ),),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            autofocus: false,
            controller: nameController,
            style: TextStyle(fontFamily: "Jameel", fontSize: 18),
            textInputAction: TextInputAction.search,
            onChanged: (String text){
              filter(text);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'سورت نام (اردو، انگلش، نمبر)',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(child: ListView.builder(
          itemCount: quranInfo.length,
          itemBuilder: (BuildContext context, int index) =>
              makeList(context, index),
        ),)
      ],),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('تلاش کریں'),
        onPressed: (){
          Route route = new MaterialPageRoute(builder: (context) => Search());
          Navigator.push(context, route);
        },
        icon: Icon(Icons.search),
      ),
    );
  }

  void filter(String query){
    if (query.isNotEmpty) {
      List<Info> dummySearchList = List<Info>();
      dummySearchList.addAll(QuranInfo.info);
      List<Info> dummyListData = List<Info>();
      dummySearchList.forEach((item) {
        int id = item.id;
        String eng = item.engName.toLowerCase();
        String urdu = item.urduName;
        if (id.toString().contains(query) || eng.contains(query.toLowerCase()) || urdu.contains(query)){
          dummyListData.add(item);
        }
      });
      setState(() {
        quranInfo.clear();
        quranInfo.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        quranInfo.clear();
        quranInfo.addAll(QuranInfo.info);
      });
    }
  }

  Widget makeList(BuildContext context, int index) {
    Info info = quranInfo[index];
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            // Route route = MaterialPageRoute(builder: (context) =>
            //     AyatDetailViewPager(position: info.id, title: info.urduName,));
            // Navigator.push(context, route);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    info.urduName,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: "NooreHuda",
                        fontSize: 22
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        info.engName
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(info.id.toString(),
                    style: TextStyle(fontWeight: FontWeight.w700),),
                ),
              ],
            ),
          ),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    quranInfo.addAll(QuranInfo.info);
    dbManager.initializeDatabase();
  }
}

//class IndexListView extends StatelessWidget {
//  final List<Info> infoList;
//
//  IndexListView(this.infoList);
//
//  @override
//  Widget build(BuildContext context) {
//    return ListView.builder(
//      itemCount: infoList.length,
//      itemBuilder: (BuildContext context, int index) => makeList(context, index),
//    );
//  }
//  Widget makeList(BuildContext context, int index) {
//    Info info = infoList[index];
//    return Card(
//        elevation: 4,
//        child: InkWell(
//          borderRadius: BorderRadius.circular(4),
//          onTap: (){
//            Route route = MaterialPageRoute(builder: (context) => AyatDetailViewPager(position: index, title: info.urduName,));
//            Navigator.push(context, route);
//          },
//          child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//            child: Row(
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Expanded(
//                  flex: 1,
//                  child: Text(
//                    info.urduName,
//                    textAlign: TextAlign.right,
//                    style: TextStyle(
//                        fontFamily: "NooreHuda",
//                        fontSize: 22
//                    ),
//                  ),
//                ),
//                Expanded(
//                  flex: 1,
//                  child: Align(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                        info.engName
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(right: 16),
//                  child: Text('${index+1}', style: TextStyle(fontWeight: FontWeight.w700),),
//                ),
//              ],
//            ),
//          ),
//        )
//    );
//  }
//}