import 'dart:convert';
import 'dart:io';
import 'dart:convert' show base64, base64Encode, json;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:line_icons/line_icons.dart';
import 'package:universal_html/html.dart' as html;

import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class TodayBdayDetail extends StatefulWidget {
  String tagline;
  String urlnya;
  String jenisnya;
  String adaappbar;

  TodayBdayDetail(
      {Key key,
      @required this.tagline,
      @required this.urlnya,
      @required this.jenisnya})
      : super(key: key);

  // JsonListFilter() : super();

  @override
  TodayBdayDetailState createState() => TodayBdayDetailState();
}

class datajson {
  String usia;
  String nama;
  String kelamin;
  String thumbnail;
  String urldoc;
  String nohp;
  String email;

  datajson(
      {this.usia,
      this.nama,
      this.kelamin,
      this.thumbnail,
      this.urldoc,
      this.nohp,
      this.email});

  factory datajson.fromJson(Map<String, dynamic> json) {
    return datajson(
      usia: json["usia"] as String,
      nama: json["nama"] as String,
      kelamin: json["kelamin"] as String,
      thumbnail: json["poster_path"] as String,
      urldoc: json["urldoc"] as String,
      nohp: json["nohp"] as String,
      email: json["email"] as String,
    );
  }
}

class Post {
  final String ucapan;

  Post({
    this.ucapan,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      ucapan: json['ucapan'].toString(),
    );
  }
}

class TodayBdayDetailState extends State<TodayBdayDetail> {
  final TextEditingController _controllerfooter = new TextEditingController();

  String filter;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static var httpClient = new HttpClient();

  @override
  initState() {
    super.initState();

    getdatanya_ultah();
    getucapan1();
    getucapan2();
    getucapan3();
    getucapan4();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _launchURL(String urlnyaapa) async {
    if (await canLaunch(urlnyaapa)) {
      await launch(urlnyaapa);
    } else {
      throw 'Could not launch $urlnyaapa';
    }
  }

  List<Post> ultah01 = new List<Post>();

  var ultah02;
  var ultah03;
  var ultah04;

  Future<List<dynamic>> getucapan1() async {
    http.Response response =
        await http.get('http://sahabatsehati.org/get_ucapan1.php');
    List responseJson = json.decode(response.body);
    //print(response.body);
    ultah01 = responseJson.map((m) => new Post.fromJson(m)).toList();
    /*
    for (var i = 0; i < ultah01.length; i++) {
      print(ultah01[i].ucapan);
    }

     */

    //print(ultah01[Random().nextInt(ultah01.length)].ucapan);

    return ultah01;
  }

  Future<List<dynamic>> getucapan2() async {
    http.Response response =
        await http.get('http://sahabatsehati.org/get_ucapan2.php');
    List responseJson = json.decode(response.body);
    // print(response.body);
    ultah02 = responseJson.map((m) => new Post.fromJson(m)).toList();
    /*
    for (var i = 0; i < ultah01.length; i++) {
      print(ultah01[i].ucapan);
    }

     */

    //print(ultah01[Random().nextInt(ultah01.length)].ucapan);

    return ultah02;
  }

  Future<List<dynamic>> getucapan3() async {
    http.Response response =
        await http.get('http://sahabatsehati.org/get_ucapan3.php');
    List responseJson = json.decode(response.body);
    //print(response.body);
    ultah03 = responseJson.map((m) => new Post.fromJson(m)).toList();
    /*
    for (var i = 0; i < ultah01.length; i++) {
      print(ultah01[i].ucapan);
    }

     */

    //print(ultah01[Random().nextInt(ultah01.length)].ucapan);

    return ultah03;
  }

  Future<List<dynamic>> getucapan4() async {
    http.Response response =
        await http.get('http://sahabatsehati.org/get_ucapan4.php');
    List responseJson = json.decode(response.body);
    //print(response.body);
    ultah04 = responseJson.map((m) => new Post.fromJson(m)).toList();
    /*
    for (var i = 0; i < ultah01.length; i++) {
      print(ultah01[i].ucapan);
    }

     */

    //print(ultah01[Random().nextInt(ultah01.length)].ucapan);

    return ultah04;
  }

  List<datajson> filteredlistnya_gen = [];

  List<datajson> parsedatanya_ultah(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<datajson>((json) => datajson.fromJson(json)).toList();
  }

  Future<List<datajson>> getdatanya_ultah() async {
    print("masuk " + widget.urlnya);
    //filteredlistnya_gen = [];

    try {
      final response = await http.get(widget.urlnya);
      if (response.statusCode == 200) {
        //print('response body : ${response.body}');
        //try {
        //json.decode(response.body);
        //print('trying to decode  Respose Body result is : success');
        //} catch (Ex) {
        // print("Exepition with json decode : $Ex");
        //}

        List<datajson> list = parsedatanya_ultah(response.body);

        //filteredlistnya_gen = list;

        //print(filteredlistnya_gen.length.toString());
        //print(filteredlistnya_gen[0].judul);

        setState(() {
          filteredlistnya_gen = list;
        });
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

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.tagline, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[],
        ),
        key: _scaffoldKey,
        body: new Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Icon(
                  LineIcons.warning,
                  size: 16,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 10,
                ),
                new Text("Tap 1 persatu dari " +
                    filteredlistnya_gen.length.toString() +
                    " data dibawah ini\nTap 1 X = Kirim Via Whatsapp, Longtap = membuka Telpon"),
              ]),
            ),
            new Expanded(
                child: new ListView.builder(
                    itemCount: filteredlistnya_gen.length,
                    itemBuilder: (BuildContext ctxt, int Index) {
                      return InkWell(
                        onLongPress: () {
                          final pathDOCS =
                              "tel:" + filteredlistnya_gen[Index].nohp;

                          print("tapped " + pathDOCS);

                          _launchURL("tel:" + filteredlistnya_gen[Index].nohp);
                          /*
                          html.window.open(
                              "tel:" + filteredlistnya_gen[Index].nohp,
                              '_blank');

                           */

                          setState(() {
                            filteredlistnya_gen[Index].urldoc = "V";
                          });
                        },
                        onTap: () {
                          String ucapinnya;

                          if (int.parse(filteredlistnya_gen[Index].usia) >= 0 &&
                              int.parse(filteredlistnya_gen[Index].usia) <=
                                  17) {
                            ucapinnya =
                                ultah01[Random().nextInt(ultah01.length)]
                                    .ucapan;
                          }
                          if (int.parse(filteredlistnya_gen[Index].usia) >=
                                  18 &&
                              int.parse(filteredlistnya_gen[Index].usia) <=
                                  30) {
                            ucapinnya =
                                ultah02[Random().nextInt(ultah02.length)]
                                    .ucapan;
                          }
                          if (int.parse(filteredlistnya_gen[Index].usia) >=
                                  31 &&
                              int.parse(filteredlistnya_gen[Index].usia) <=
                                  50) {
                            ucapinnya =
                                ultah03[Random().nextInt(ultah03.length)]
                                    .ucapan;
                          }
                          if (int.parse(filteredlistnya_gen[Index].usia) >=
                              51) {
                            ucapinnya =
                                ultah04[Random().nextInt(ultah04.length)]
                                    .ucapan;
                          }
                          var encodedtextwa = Uri.encodeComponent("halo,\n\n" +
                              filteredlistnya_gen[Index].nama +
                              "\n\n" +
                              ucapinnya);

                          _launchURL("https://wa.me/" +
                              filteredlistnya_gen[Index].nohp +
                              "/?text=" +
                              encodedtextwa);
                          /*
                          html.window.open(
                              "https://wa.me/" +
                                  filteredlistnya_gen[Index].nohp +
                                  "/?text=" +
                                  encodedtextwa,
                              '_blank');

                           */

                          setState(() {
                            filteredlistnya_gen[Index].urldoc = "V";
                          });
                        },
                        child: Card(
                          margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                          elevation: 1,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      new Text(filteredlistnya_gen[Index].nama,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: new Text(
                                            filteredlistnya_gen[Index]
                                                .thumbnail),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: new Text(
                                            filteredlistnya_gen[Index].usia +
                                                " Tahun"),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      filteredlistnya_gen[Index]
                                              .urldoc
                                              .contains("V")
                                          ? new Icon(
                                              Icons.done,
                                              size: 20,
                                              color: Colors.green,
                                            )
                                          : Container(),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child:
                                      new Text(filteredlistnya_gen[Index].nohp),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: new Text(
                                      filteredlistnya_gen[Index].kelamin),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: new Text(
                                    filteredlistnya_gen[Index].email,
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                ),
                              ]),
                        ),
                      );
                    }))
          ],
        ));
  }
}
