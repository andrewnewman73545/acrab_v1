import 'package:acrab/BDAY/BdayCalendarFirst.dart';
import 'package:acrab/BDAY/ScrollBday.dart';
import 'package:acrab/UCAPAN/BankDataUcapanListView.dart';
import 'package:acrab/PERSON/AddNewPerson.dart';
import 'package:acrab/BDAY/TodayBdayGrid.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../TEAM/AboutInfo.dart';

class HomeScreenPlain extends StatefulWidget {
  String nama = "";

  HomeScreenPlain({
    Key key,
    @required this.nama,
  }) : super(key: key);

  final colors = [Colors.grey[300], Colors.grey[300]];

  @override
  _HomeScreenPlainState createState() => _HomeScreenPlainState();
}

class _HomeScreenPlainState extends State<HomeScreenPlain>
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
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            title: new Text(
              "ACRAB",
              style: TextStyle(color: Colors.black),
            ),
          ),
          key: _scaffoldKey,
          bottomNavigationBar: SizedBox(
            height: 90,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.birthday_cake, size: 20),
                    title: Text("Birthday")),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.calendar, size: 20),
                    title: Text("Calender")),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.list, size: 20),
                    title: Text("ListBday")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.whatshot, size: 20),
                    title: Text("Data Entry")),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.file_text_o, size: 20),
                    title: Text("TextBank")),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.crosshairs, size: 20),
                    title: Text("About")),
              ],
              currentIndex: selectedPosition,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.red,
              selectedIconTheme: const IconThemeData(color: Colors.red),
              unselectedIconTheme: const IconThemeData(color: Colors.grey),
              onTap: (position) {
                setState(() {
                  selectedPosition = position;
                });
              },
            ),
          ),
          body: Builder(builder: (context) {
            //return Container();
            return listBottomWidget[selectedPosition];
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
    listBottomWidget.add(BdayCalendar2());
    listBottomWidget.add(ScrollBday());

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
