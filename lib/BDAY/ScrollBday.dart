import 'package:flutter/material.dart';
import 'package:side_header_list_view/side_header_list_view.dart';

class ScrollBday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SideHeaderListView(
        itemCount: names.length,
        padding: new EdgeInsets.all(16.0),
        itemExtend: 48.0,
        headerBuilder: (BuildContext context, int index) {
          return new SizedBox(
              width: 100.0,
              child: new Text(
                names[index].substring(0, 7),
                style: TextStyle(color: Colors.redAccent),
              ));
        },
        itemBuilder: (BuildContext context, int index) {
          return new Text(
            names[index].substring(7, names[index].length),
          );
        },
        hasSameHeader: (int a, int b) {
          return names[a].substring(0, 7) == names[b].substring(0, 7);
        },
      ),
    );
  }
}

const names = const <String>[
  '10 Ags Andrew 10 Tahun',
  '10 Ags Andrew',
  '10 Ags Andrew',
  '11 Ags Andrew',
  '11 Ags Andrew',
  '11 Ags Andrew',
  '11 Ags Andrew',
  '11 Ags Andrew',
  '11 Ags Andrew',
  '11 Ags Andrew',
  '11 Ags Andrew',
  '12 Ags Andrew',
  '12 Ags Andrew',
  '13 Ags Andrew',
  '13 Ags Andrew',
  '14 Ags Andrew',
  '15 Ags Andrew',
  '16 Ags Andrew',
  '16 Ags Andrew',
  '16 Ags Andrew',
  '17 Ags Andrew',
  '17 Ags Andrew',
  '18 Ags Andrew',
  '18 Ags Andrew',
  '19 Ags Andrew',
  '19 Ags Andrew',
  '19 Ags Andrew',
  '19 Ags Andrew',
  '20 Ags Andrew',
  '21 Ags Andrew',
  '22 Ags Andrew',
  '23 Ags Andrew',
  '24 Ags Andrew',
];
