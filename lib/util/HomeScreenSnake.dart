import 'package:acrab/UCAPAN/BankDataUcapanListView.dart';
import 'package:acrab/PERSON/AddNewPerson.dart';
import 'package:acrab/BDAY/TodayBdayGrid.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../TEAM/AboutInfo.dart';

class HomeScreenSnake extends StatefulWidget {
  String nama = "";

  HomeScreenSnake({
    Key key,
    @required this.nama,
  }) : super(key: key);

  final colors = [Colors.grey[300], Colors.grey[300]];

  @override
  _HomeScreenSnakeState createState() => _HomeScreenSnakeState();
}

class _HomeScreenSnakeState extends State<HomeScreenSnake>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PageController _pageController;

  String harix;
  String bulanx;

  int selectedPosition = 0;
  List<Widget> listBottomWidget = new List();

  int selectedIndex = 0;

  @override
  void initState() {
    final DateTime now = DateTime.now();
    final DateFormat formattertgl = DateFormat('dd');
    final DateFormat formatterbln = DateFormat('MM');

    harix = formattertgl.format(now);
    bulanx = formatterbln.format(now);

    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);

    addHomePage();

    super.initState();
  }

  void handlePageChange() {
    // _menuPositionController.absolutePosition = _pageController.page;
  }

  @override
  void dispose() {
    //  controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: SalomonBottomBar(
            items: [
              SalomonBottomBarItem(
                icon: Icon(LineIcons.birthday_cake),
                title: Text("Birthday"),
                selectedColor: Colors.red,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.whatshot),
                title: Text("Data Entry"),
                selectedColor: Colors.orange,
              ),
              SalomonBottomBarItem(
                icon: Icon(LineIcons.file_text_o),
                title: Text("TextBank"),
                selectedColor: Colors.green,
              ),
              SalomonBottomBarItem(
                icon: Icon(LineIcons.crosshairs),
                title: Text("About"),
                selectedColor: Colors.blue,
              ),
            ],
            onTap: (position) {
              setState(() {
                selectedPosition = position;
              });
            },
            currentIndex: selectedPosition,
          ),
          body: Builder(builder: (context) {
            //return listBottomWidget[selectedPosition];
            return Container();
          })),
    );
  }

  void addHomePage() {
    listBottomWidget.add(TodayBdayGrid(
      jumlahkolom: 1,
      urlnya: "http://sahabatsehati.org/TodayBday.php?hari=" +
          harix +
          "&bulan=" +
          bulanx,
      namauser: widget.nama,
    ));

    listBottomWidget.add(AddNewPersonPage(adaappbar: "N"));
    listBottomWidget.add(BankDataUcapanListView());
    listBottomWidget.add(AboutInfo(
        tagline: "Our Team",
        urlnya: "http://sahabatsehati.org/getinfo.php?id=1"));
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      duration: Duration(seconds: 1),
    ));
  }
}
