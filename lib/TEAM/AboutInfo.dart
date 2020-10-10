import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:transparent_image/transparent_image.dart';

class AboutInfo extends StatefulWidget {
  String tagline = "";
  String urlnya = "";

  AboutInfo({
    Key key,
    @required this.tagline,
    @required this.urlnya,
  }) : super(key: key);

  @override
  _AboutInfoState createState() => _AboutInfoState();
}

class _AboutInfoState extends State<AboutInfo> {
  double sizefontnya = 17.0;
  var datadoc;

  bool isLoading = false;

  void initState() {
    super.initState();

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = width;

    return Scaffold(
      body: Center(
        child: FutureBuilder<Hasiljson>(
          future: getQuote(),
          //sets the getQuote method as the expected Future
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //checks if the response returns valid data

              datadoc = snapshot.data.jsonhtml;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //displays the quote
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        snapshot.data.thumbnail,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: HtmlWidget(
                        snapshot.data.jsonhtml,
                      ),
                    ),
                    SizedBox(
                      height: 500.0,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              //checks if the response throws an error
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  Future<Hasiljson> getQuote() async {
    String url = widget.urlnya;
    print(url);
    final response =
        await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      return Hasiljson.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

class Hasiljson {
  final String thumbnail;
  final String jsonhtml;

  Hasiljson({
    this.thumbnail,
    this.jsonhtml,
  });

  factory Hasiljson.fromJson(Map<String, dynamic> json) {
    return Hasiljson(
      thumbnail: json['backdrop_path'],
      jsonhtml: json['keterangan'],
    );
  }
}
