import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  int currentValue = 0;
  String currentText = '';
  List<GroupModel> group = [
    GroupModel(text: 'قرآن', index: 0),
    GroupModel(text: 'ترجمہ', index: 1),
    GroupModel(text: 'تفسیر', index: 2)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تلاش کریں',style: TextStyle(fontFamily: "Jameel"),),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              children: <Widget>[
                TextField(
                  style: TextStyle(fontFamily: "Jameel", fontSize: 18),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'یہاں لکھیں',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: group.map((t) =>
                      Expanded(
                        child: RadioListTile(
                          title: Text("${t.text}",style: TextStyle(fontFamily: "Jameel"),),
                          groupValue: currentValue,
                          value: t.index,
                          onChanged: (val) {
                            setState(() {
                              currentValue = val;
                              currentText = t.text;
                            });
                            print(t.text);
                          },
                        ),
                      ))
                      .toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GroupModel{
  String text;
  int index;
  GroupModel({this.text, this.index});

}
