import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart' as http;

class BankDataEditDelete extends StatefulWidget {
  final List list;
  final int index;
  final String kriteria;

  BankDataEditDelete({this.list, this.index, this.kriteria});

  @override
  _BankDataEditDeleteState createState() => new _BankDataEditDeleteState();
}

class _BankDataEditDeleteState extends State<BankDataEditDelete> {
  TextEditingController controllerUcapan;
  TextEditingController controllerKriteria;

  void _showAlert1(bool isFromTop, String judul, String ket) {
    EdgeAlert.show(context,
        title: judul,
        description: ket,
        backgroundColor: Colors.red,
        gravity: isFromTop ? EdgeAlert.TOP : EdgeAlert.BOTTOM);
  }

  void _showsukses1(bool isFromTop, String judul, String ket) {
    EdgeAlert.show(context,
        title: judul,
        description: ket,
        icon: Icons.done,
        backgroundColor: Colors.green,
        gravity: isFromTop ? EdgeAlert.TOP : EdgeAlert.BOTTOM);
  }

  Future<void> editData() async {
    var url = "http://sahabatsehati.org/BankTexteditdata.php";

    http.Response responsey = await http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "itemname": controllerUcapan.text,
      "stock": controllerKriteria.text
    });

    print(responsey.body);

    if (responsey.body.toString().contains("SUKSES")) {
      _showsukses1(true, "Penyimpanan", responsey.body);
    } else {
      _showAlert1(false, "Penyimpanan", responsey.body);
    }
    Navigator.pop(context, () {
      setState(() {});
    });
    // Navigator.pop(context);
  }

  var kriteriax = ['USIA_01_17', 'USIA_18_30', 'USIA_31_50', 'USIA_51_UP'];

  void deleteData() {
    var url = "http://sahabatsehati.org/BankTextdeletedata.php";
    http.post(url, body: {'id': widget.list[widget.index]['id']});

    _showsukses1(true, "penghapusan", "Sukses");

    // Navigator.pop(context);
  }

  @override
  void initState() {
    controllerUcapan =
        new TextEditingController(text: widget.list[widget.index]['ucapan']);

    controllerKriteria =
        new TextEditingController(text: widget.list[widget.index]['kriteria']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        title: new Text(
          "EDIT/HAPUS DATA",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  controller: controllerUcapan,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ucapan",
                      labelText: "Ucapan"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Kriteria"),
                ),
                DropDown(
                  items: [
                    "USIA_01_17",
                    "USIA_18_30",
                    "USIA_31_50",
                    "USIA_51_UP",
                  ],
                  initialValue: controllerKriteria.text,
                  hint: Text("Kriteria"),
                  onChanged: (value) {
                    controllerKriteria.text = value;
                    print(controllerKriteria.text);
                  },
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new RaisedButton(
                          child: new Text("HAPUS"),
                          color: Colors.red,
                          onPressed: () {
                            deleteData();
                            Navigator.pop(context);
                          }),
                      SizedBox(
                        width: 100,
                      ),
                      new RaisedButton(
                        child: new Text("SIMPAN"),
                        color: Colors.blueAccent,
                        onPressed: () {
                          editData();
                        },
                      ),
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
