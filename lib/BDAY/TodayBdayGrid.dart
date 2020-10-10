import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:acrab/BDAY/TodayBdayDetail.dart';
import 'package:line_icons/line_icons.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';

import 'TodayBdayDetail.dart';

class TodayBdayGrid extends StatefulWidget {
  int jumlahkolom;
  String urlnya;
  String namauser;

  TodayBdayGrid({
    Key key,
    @required this.jumlahkolom,
    @required this.urlnya,
    @required this.namauser,
  }) : super(key: key);

  // JsonListFilter() : super();

  @override
  TodayBdayGridState createState() => TodayBdayGridState();
}

class datajson5 {
  String judul;
  String jumlah;

  datajson5({this.judul, this.jumlah});

  factory datajson5.fromJson(Map<String, dynamic> json) {
    return datajson5(
        judul: json["judul"] as String, jumlah: json["jumlah"] as String);
  }
}

class TodayBdayGridState extends State<TodayBdayGrid> {
  TextEditingController controller = new TextEditingController(text: "");
  String filter;

  String harix;
  String bulanx;
  String urlnow;

  final TextEditingController _controllertgl = new TextEditingController();
  final TextEditingController _controllerbln = new TextEditingController();

  @override
  initState() {
    super.initState();

    final DateTime now = DateTime.now();
    final DateFormat formattertgl = DateFormat('dd');
    final DateFormat formatterbln = DateFormat('MM');

    harix = formattertgl.format(now);
    bulanx = formatterbln.format(now);

    //print(formatted); // someth

    _controllertgl.text = harix;
    _controllerbln.text = bulanx;
    urlnow = "http://sahabatsehati.org/TodayBday.php?hari=" +
        _controllertgl.text +
        "&bulan=" +
        _controllerbln.text;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<datajson5> listnya = [];
  List<datajson5> filteredlistnya = [];

  List<datajson5> parsedatanya(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<datajson5>((json) => datajson5.fromJson(json)).toList();
  }

  Future<List<datajson5>> getdatanya(String baseurl) async {
    //print("masuk " + widget.urlnya);

    print("masuk " + baseurl);

    try {
      final response = await http.get(baseurl);
      if (response.statusCode == 200) {
        List<datajson5> list = parsedatanya(response.body);

        filteredlistnya = list;

        return filteredlistnya;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.hasData) {
          return Scaffold(
              body: Column(children: [
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
            /*
            Container(
              alignment: Alignment.center,
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: new Text("Hi, " +
                    widget.namauser.replaceAll("}]", "").replaceAll('"', "") +
                    ",  ini adalah Daftar yang berulang Tahun\n\n"),
              ),
            ),

             */
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Tanggal"),
                    new Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: TouchSpin(
                        min: 1,
                        max: 31,
                        step: 1,
                        value: int.parse(harix),
                        textStyle: TextStyle(fontSize: 15),
                        iconSize: 15.0,
                        addIcon: Icon(LineIcons.plus_square_o),
                        subtractIcon: Icon(LineIcons.minus_square_o),
                        //plain : iconActiveColor: Colors.black,
                        //fancy  :
                        iconActiveColor: Colors.redAccent,

                        iconDisabledColor: Colors.grey,
                        onChanged: (val) {
                          _controllertgl.text = val.toString().padLeft(2, '0');
                          print(_controllertgl.text);
                          setState(() {
                            urlnow =
                                "http://sahabatsehati.org/TodayBday.php?hari=" +
                                    _controllertgl.text +
                                    "&bulan=" +
                                    _controllerbln.text;
                          });
                        },
                      ),
                    ),
                    Text("Bulan"),
                    new Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: TouchSpin(
                          min: 1,
                          max: 12,
                          step: 1,
                          value: int.parse(bulanx),
                          textStyle: TextStyle(fontSize: 15),
                          iconSize: 15.0,
                          addIcon: Icon(LineIcons.plus_square_o),
                          subtractIcon: Icon(LineIcons.minus_square_o),
                          //plain:  iconActiveColor: Colors.black,
                          iconActiveColor: Colors.redAccent,

                          iconDisabledColor: Colors.grey,
                          onChanged: (val) {
                            _controllerbln.text =
                                val.toString().padLeft(2, '0');
                            print(_controllerbln.text);
                            setState(() {
                              urlnow =
                                  "http://sahabatsehati.org/TodayBday.php?hari=" +
                                      _controllertgl.text +
                                      "&bulan=" +
                                      _controllerbln.text;
                            });
                          },
                        ))
                  ]),
            ),
            Container(
              alignment: Alignment.center,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text("Klik pada Group untuk Melihat Detail",
                    style: TextStyle(fontSize: 15, color: Colors.redAccent)),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.jumlahkolom,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 10)),
                  itemCount: filteredlistnya.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print("tapped " +
                            "http://sahabatsehati.org/TodayBdayDetail.php?category=" +
                            filteredlistnya[index]
                                .judul
                                .replaceAll(" ", "%20") +
                            "&hari=" +
                            _controllertgl.text +
                            "&bulan=" +
                            _controllerbln.text);

                        Route route = MaterialPageRoute(
                            builder: (context) => TodayBdayDetail(
                                  tagline: filteredlistnya[index].judul,
                                  urlnya:
                                      "http://sahabatsehati.org/TodayBdayDetail.php?category=" +
                                          filteredlistnya[index]
                                              .judul
                                              .replaceAll(" ", "%20") +
                                          "&hari=" +
                                          _controllertgl.text +
                                          "&bulan=" +
                                          _controllerbln.text,
                                  jenisnya: "TELP",
                                ));

                        Navigator.push(context, route);
                      },
                      child: Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                color: Colors.red[400],
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 3),
                                  child: Row(children: [
                                    Icon(
                                      LineIcons.group,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      filteredlistnya[index].judul,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ]),
                                )),
                            SizedBox(
                                height: 20.0,
                                child: Text(
                                    filteredlistnya[index].jumlah + "  ",
                                    style: TextStyle(fontSize: 12.0)))
                          ])),
                    );
                  },
                ),
              ),
            ),
            /*
            Container(
              alignment: Alignment.center,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                    "Untuk menambahkan Data yg tampil disini\nbisa TAP di Data Entry."),
              ),
            ),
                */
          ]));
        } else if (projectSnap.hasError) {
          //checks if the response throws an error
          return Text("${projectSnap.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
      future: getdatanya(urlnow),
    );
  }
}
