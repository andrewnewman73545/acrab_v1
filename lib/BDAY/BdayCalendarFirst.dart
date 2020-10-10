import 'dart:convert';

import 'package:acrab/util/flutter_clean_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//     final ultahcal = ultahcalFromJson(jsonString);

Ultahcal ultahcalFromJson(String str) => Ultahcal.fromJson(json.decode(str));

String ultahcalToJson(Ultahcal data) => json.encode(data.toJson());

class Ultahcal {
  Ultahcal({
    this.data,
  });

  List<Datum> data;

  factory Ultahcal.fromJson(Map<String, dynamic> json) => Ultahcal(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.tgl,
    this.ultah,
  });

  DateTime tgl;
  List<Ultah> ultah;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        tgl: DateTime.parse(json["tgl"]),
        ultah: List<Ultah>.from(json["ultah"].map((x) => Ultah.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tgl":
            "${tgl.year.toString().padLeft(4, '0')}-${tgl.month.toString().padLeft(2, '0')}-${tgl.day.toString().padLeft(2, '0')}",
        "ultah": List<dynamic>.from(ultah.map((x) => x.toJson())),
      };
}

class Ultah {
  Ultah({
    this.name,
  });

  String name;

  factory Ultah.fromJson(Map<String, dynamic> json) => Ultah(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Namaygultah {
  String name;
  bool isDone;

  Namaygultah(this.name, this.isDone);

  @override
  String toString() {
    return "{ name : ${this.name} , isDone : ${this.isDone} }";
  }
}

class BdayCalendar2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BdayCalendar2State();
  }
}

class _BdayCalendar2State extends State<BdayCalendar2> {
  // List _events;

  List _selectedEvents;
  DateTime _selectedDay;

  Future<Map<DateTime, List>> getBdaycal() async {
    Map<DateTime, List> _eventsnew = {};

    var res = await http.get(
        Uri.encodeFull('http://sahabatsehati.org/TodayBdayCal.php'),
        headers: {'accept': 'application/json'});

    var content = res.body;

    // print(content);

    Ultahcal event = ultahcalFromJson(content);

    for (int i = 0; i < event.data.length; i++) {
      List listNamaygultah = [];
      // var listNamaygultah = [];

      for (int x = 0; x < event.data[i].ultah.length; x++) {
        // print(event.data[i].ultah[x].name.toString());

        var details = {'name': event.data[i].ultah[x].name, 'isDone': true};
        listNamaygultah.add(details);
        // listNamaygultah.add(Namaygultah(event.data[i].ultah[x].name, true));
        // print(x);
      }

      //print(listNamaygultah);
      // print("listnamaygultah = " + listNamaygultah.length.toString());

      var cek = DateTime(event.data[i].tgl.year, event.data[i].tgl.month,
          event.data[i].tgl.day);

      Map<DateTime, List> _eventsnew = {cek: listNamaygultah};

      print(_eventsnew);

      var skrg = DateTime.now();

      setState(() {
        _events.addAll(_eventsnew);
        _selectedDay = skrg;
        _selectedEvents = _events[_selectedDay] ?? [];
        _handleNewDate(DateTime.parse(tglindo));
      });
    }

    //xx = xxx;
    //print("COMBINE: ");

    //print(xx);
    return _eventsnew;
  }

  //List _selectedEvents;
  //DateTime _selectedDay;

  Map<DateTime, List> _events = {
    DateTime(2020, 10, 10): [
      {'name': 'LOADING..', 'isDone': true},
    ],
  };

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd 00:00:00');
  static final String tglindo = formatter.format(now);

  void _handleNewDate(date) {
    print('masuk handlenewdate');

    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
  }

  @override
  void initState() {
    final _selectedDay = DateTime.now();
    // _selectedEvents = [];

    getBdaycal();
    //print(xx);

    setState(() {
      //_events.clear();
      //_events = _eventsnew;
      _selectedEvents = _events[_selectedDay] ?? [];
    });

    //lsg tampilkan yg ultah
    _handleNewDate(DateTime.parse(tglindo));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  dynamic myDateSerializer(dynamic object) {
    if (object is DateTime) {
      return object.toIso8601String();
    }
    return object;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Calendar(
                startOnMonday: true,
                weekDays: ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"],
                events: _events,
                onRangeSelected: (range) =>
                    print("Range is ${range.from}, ${range.to}"),
                onDateSelected: (date) {
                  _handleNewDate(date);
                },
                isExpandable: true,
                eventDoneColor: Colors.green,
                selectedColor: Colors.pink,
                todayColor: Colors.blue,
                eventColor: Colors.grey,
                dayOfWeekStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 11),
              ),
            ),
            _buildEventList()
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ListTile(
            title: Text(_selectedEvents[index]['name'].toString()),
            onTap: () {
              print("pilih : " +
                  _selectedEvents[index]['name'] +
                  " " +
                  _selectedEvents[index]['isDone'].toString());
            },
          ),
        ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}
