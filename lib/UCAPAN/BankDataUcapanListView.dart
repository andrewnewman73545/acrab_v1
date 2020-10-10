import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import './BankData_add.dart';
import 'BankData_editdelete.dart';
import 'package:line_icons/line_icons.dart';

class BankDataUcapanListView extends StatefulWidget {
  @override
  _BankDataUcapanListViewState createState() =>
      new _BankDataUcapanListViewState();
}

class _BankDataUcapanListViewState extends State<BankDataUcapanListView> {
  bool ulang;

  @override
  initState() {
    super.initState();
    setState(() {
      ulang = false;
    });
  }

  Future<List> getData() async {
    final response =
        await http.get("http://sahabatsehati.org/BankTextgetdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        floatingActionButton: new FloatingActionButton(
            backgroundColor: Colors.redAccent,
            child: new Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BankDataAdd()),
              ).then((value) => setState(() {}));
            }),
        body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data,
                  )
                : new Center(
                    child: new CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return new Column(children: [
      SizedBox(
        height: 50,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: "http://188.166.185.138/header.png",
              fit: BoxFit.contain),
        ),
      ),
      Container(
        alignment: Alignment.center,
        width: width,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: new Text(
              "Tersedia [" +
                  list.length.toString() +
                  "] data Ucapan Ulang Tahun ",
              style: TextStyle(color: Colors.black)),
        ),
      ),
      new Expanded(
        child: new ListView.builder(
          itemCount: list == null ? 0 : list.length,
          itemBuilder: (context, i) {
            return new Container(
              padding: const EdgeInsets.all(10.0),
              child: new GestureDetector(
                onTap: () async {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BankDataEditDelete(list: list, index: i)));
                },
                child: Card(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                  elevation: 1,
                  child: new ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 8, right: 8, top: 5),
                    leading: Icon(
                      LineIcons.paperclip,
                      color: Colors.red,
                      size: 20,
                    ),
                    title: new Text(
                      list[i]['ucapan'],
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: new Text("Kriteria : ${list[i]['kriteria']}"),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
