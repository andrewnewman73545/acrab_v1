import 'dart:convert';
import 'dart:math';
import 'package:acrab/util/HomeScreenCurved.dart';
import 'package:acrab/util/HomeScreenFancy.dart';
import 'package:acrab/util/HomeScreenPlain.dart';
import 'package:acrab/util/HomeScreenSnake.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:acrab/BDAY/TodayBdayDetail.dart';
import 'package:line_icons/line_icons.dart';
import 'package:transparent_image/transparent_image.dart';

class PasswordBeforeAkses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCustomFormx();
  }
}

// Define a custom Form widget.
class MyCustomFormx extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomFormx>
    with TickerProviderStateMixin {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  Animation _arrowAnimation, _heartAnimation;
  AnimationController _arrowAnimationController, _heartAnimationController;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);

    _heartAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _heartAnimation = Tween(begin: 150.0, end: 170.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _heartAnimationController));

    _heartAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _heartAnimationController.repeat();
      }
    });

    _heartAnimationController.forward();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                width: width,
                height: 200.0,
                child: AnimatedBuilder(
                  animation: _heartAnimationController,
                  builder: (context, child) {
                    return Center(
                      child: Container(
                        child: Center(
                          child: Image(
                            image: AssetImage("images/logot.png"),
                            width: _heartAnimation.value,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                  width: width,
                  height: 70.0,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              LineIcons.warning,
                              size: 16,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                "Hanya Untuk yang sudah diotorisasi\nMasukan Sandi Akses untuk Melanjutkan"),
                          ]))),
              new Container(
                  margin: const EdgeInsets.only(right: 100, left: 100),
                  child: new TextField(
                    controller: myController,
                    obscureText: true,
                    decoration: new InputDecoration(
                        hintText: 'Akses Key', icon: new Icon(Icons.lock)),
                  )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          // When the user presses the button, show an alert dialog containing
          // the text that the user has entered into the text field.
          onPressed: () async {
            print('http://sahabatsehati.org/cekakses.php?akseskey=' +
                myController.text);

            //cek token apakah terdaftar..
            final http.Response responsex = await http.get(
                'http://sahabatsehati.org/cekakses.php?akseskey=' +
                    myController.text);

            final int statusCode = responsex.statusCode;

            if (statusCode < 200 || statusCode > 400 || json == null) {
              throw new Exception("Error while fetching data");
            }

            print('Response from server: ${responsex.body}');

            var arr = responsex.body.toString().split('|');

            if (responsex.body.toString().contains("Y")) {
              //no back fitur to logim

              Route route = MaterialPageRoute(
                  builder: (context) => HomeScreenPlain(nama: arr[1]));

              //Route route = MaterialPageRoute(
              //   builder: (context) => HomeScreenSnake(nama: arr[1]));

              //andrew preset style
              //Route route = MaterialPageRoute(
              //    builder: (context) => HomeScreenFancy(nama: arr[1]));

              //Route route = MaterialPageRoute(
              //    builder: (context) => HomeScreenCurved(nama: arr[1]));

              Navigator.pushReplacement(context, route);
            } else {
              _showDialog();
            }
          },
          tooltip: 'Masuk Menu Utama',
          child: Icon(Icons.done),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("MAAF"),
          content: new Text(
              "Akses Key  itu tidak diketemukan didata, bisa hubungi 08111663307  bila Anda Lupa atau ingin mendapatkan Akses"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
