import 'dart:convert';
import 'dart:math';
import 'package:acrab/util/HomeScreenCurved.dart';
import 'package:acrab/util/HomeScreenFancy.dart';
import 'package:acrab/util/HomeScreenPlain.dart';
import 'package:acrab/util/HomeScreenSnake.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:acrab/BDAY/TodayBdayDetail.dart';
import 'package:im_animations/im_animations.dart';
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
        // backgroundColor: Colors.lightGreen,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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

              /*


              SizedBox(
                width: width,
                child: TypewriterAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Acrab come to rescue",
                  ],
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                  alignment: AlignmentDirectional.topCenter,
                  repeatForever: true,
                ),
              ),

              SizedBox(
                height: 100,
                child: WavyAnimatedTextKit(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                  text: [
                    "Acrab",
                    "come to rescue",
                  ],
                  isRepeatingAnimation: true,
                ),
              ),

               */
              SizedBox(
                  width: width,
                  height: 150,
                  child: Center(
                    child: Container(
                      child: HeartBeat(
                        beatsPerMinute: 20,
                        child: Image(
                          image: AssetImage("images/logot.png"),
                          width: _heartAnimation.value,
                        ),
                      ),
                      /*Rotate(
                        rotationsPerMinute: 5,
                        repeat: true,
                        child: Image(
                          image: AssetImage("images/logot.png"),
                          width: _heartAnimation.value,
                        ),
                      ),
                      Sonar(
                        radius: 100,
                        waveColor: Colors.red,
                        child: Image(
                          image: AssetImage("images/logot.png"),
                          width: _heartAnimation.value,
                        ),
                      ),
                      HeartBeat(
                        beatsPerMinute: 90,
                        child: Image(
                          image: AssetImage("images/logot.png"),
                          width: _heartAnimation.value,
                        ),
                      ),

                      ColorSonar(
                        contentAreaRadius: 100.0,
                        waveFall: 15.0,
                        waveMotion: WaveMotion.synced,
                        child: Image(
                          image: AssetImage("images/logot.png"),
                          width: _heartAnimation.value,
                        ),
                      ),

                       */
                    ),
                  )),
              /*
              SizedBox(
                width: width,
                height: 100,
                child: ScaleAnimatedTextKit(
                    onTap: () {
                      print("Tap Event");
                    },
                    repeatForever: true,
                    text: [
                      "Lupa? Kirim Ucapan Ulang Tahun?",
                      "Pake aja ACRAB apps"
                    ],
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                    alignment:
                        AlignmentDirectional.topCenter // or Alignment.topLeft
                    ),
              ),
              */
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: width,
                  height: 50,
                  child: TypewriterAnimatedTextKit(
                    onTap: () {
                      print("Tap Event");
                    },
                    text: [
                      "sering, Lupa Ulang Tahun Jemaat?",
                      "...",
                      "Pakai, A-CRAB Apps Dong!",
                      "...",
                      "Tunjukan kamu Perduli.",
                      "..."
                    ],
                    textStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.topCenter,
                    repeatForever: true,
                  ),
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
                                "Alpha Release 1.0\nUI/UX still under development\n\nMasukan Sandi Akses (Hint: c4g) ",
                                style: TextStyle(fontSize: 10)),
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

              // Route route = MaterialPageRoute(
              //     builder: (context) => HomeScreenPlain(nama: arr[1]));

              // Route route = MaterialPageRoute(
              //     builder: (context) => HomeScreenSnake(nama: arr[1]));

              //andrew preset style
              Route route = MaterialPageRoute(
                  builder: (context) => HomeScreenFancy(nama: arr[1]));

              //Route route = MaterialPageRoute(
              //   builder: (context) => HomeScreenCurved(nama: arr[1]));

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
