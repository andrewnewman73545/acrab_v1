import 'package:acrab/BDAY/BdayCalendarFirst.dart';
import 'package:acrab/UCAPAN/BankDataUcapanListView.dart';
import 'package:acrab/PERSON/AddNewPerson.dart';
import 'package:acrab/BDAY/TodayBdayGrid.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../TEAM/AboutInfo.dart';

class HomeScreenFancy extends StatefulWidget {
  String nama = "";

  HomeScreenFancy({
    Key key,
    @required this.nama,
  }) : super(key: key);

  final colors = [Colors.grey[300], Colors.grey[300]];

  @override
  _HomeScreenFancyState createState() => _HomeScreenFancyState();
}

class _HomeScreenFancyState extends State<HomeScreenFancy>
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
              style: TextStyle(color: Colors.red),
            ),
          ),
          key: _scaffoldKey,
          bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.white,
              selectedItemBorderColor: Colors.transparent,
              selectedItemBackgroundColor: Colors.green,
              selectedItemIconColor: Colors.white,
              selectedItemLabelColor: Colors.black,
              showSelectedItemShadow: false,
              barHeight: 70,
            ),
            items: [
              FFNavigationBarItem(
                iconData: LineIcons.calendar,
                label: "Birthday",
                selectedBackgroundColor: Colors.red,
              ),
              FFNavigationBarItem(
                iconData: LineIcons.birthday_cake,
                label: "Kirim",
                selectedBackgroundColor: Colors.red,
              ),
              FFNavigationBarItem(
                iconData: Icons.whatshot,
                label: "Data Entry",
                selectedBackgroundColor: Colors.red,
              ),
              FFNavigationBarItem(
                iconData: LineIcons.file_text_o,
                label: "TextBank",
                selectedBackgroundColor: Colors.red,
              ),
              FFNavigationBarItem(
                iconData: LineIcons.crosshairs,
                label: "About",
                selectedBackgroundColor: Colors.blue,
              ),
            ],
            selectedIndex: selectedPosition,
            onSelectTab: (index) {
              setState(() {
                selectedPosition = index;
              });
            },
          ),
          body: Builder(builder: (context) {
            return listBottomWidget[selectedPosition];
            //return Container();
          })),
    );
  }

  void addHomePage() {
    listBottomWidget.add(BdayCalendar2());
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
