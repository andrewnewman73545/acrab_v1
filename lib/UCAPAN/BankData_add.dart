import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart' as http;

class BankDataAdd extends StatefulWidget {
  @override
  _BankDataAddState createState() => new _BankDataAddState();
}

class _BankDataAddState extends State<BankDataAdd> {
  TextEditingController controllerUcapan = new TextEditingController();
  TextEditingController controllerKriteria = new TextEditingController();

  var kriteriax = ['USIA_01_17', 'USIA_18_30', 'USIA_31_50', 'USIA_51_UP'];

  Future<void> addData() async {
    var url = "http://sahabatsehati.org/BankTextadddata.php";

    http.Response response = await http.post(url, body: {
      "ucapan": controllerUcapan.text,
      "kriteria": controllerKriteria.text
    });
    print(response.body);

    if (response.body.toString().contains("SUKSES")) {
      _showsukses(true, "Penyimpanan", response.body);
    } else {
      _showAlert(false, "Penyimpanan", response.body);
    }
    Navigator.pop(context, () {
      setState(() {});
    });
  }

  @override
  initState() {
    super.initState();
    setState(() {
      controllerKriteria.text = "USIA_18_30";
    });
  }

  void _showAlert(bool isFromTop, String judul, String ket) {
    EdgeAlert.show(context,
        title: judul,
        description: ket,
        backgroundColor: Colors.red,
        gravity: isFromTop ? EdgeAlert.TOP : EdgeAlert.BOTTOM);
  }

  void _showsukses(bool isFromTop, String judul, String ket) {
    EdgeAlert.show(context,
        title: judul,
        description: ket,
        icon: Icons.done,
        backgroundColor: Colors.green,
        gravity: isFromTop ? EdgeAlert.TOP : EdgeAlert.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        title: new Text(
          "TAMBAH",
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
                  initialValue: "USIA_18_30",
                  hint: Text("Kriteria"),
                  onChanged: (value) {
                    controllerKriteria.text = value;
                    print(controllerKriteria.text);
                  },
                ),

                /*
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new PopupMenuButton<String>(
                        child: Text(
                          "Klik\nPilih",
                          style: TextStyle(color: Colors.red),
                        ),
                        onSelected: (String value) {
                          controllerStock.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return kriteriax
                              .map<PopupMenuItem<String>>((String value) {
                            return new PopupMenuItem(
                                child: new Text(value), value: value);
                          }).toList();
                        },
                      ),
                      Expanded(
                        child: new TextField(
                          controller: controllerStock,
                          readOnly: true,
                          decoration: new InputDecoration(
                              hintText: "Kriteria", labelText: "Kriteria"),
                        ),
                      ),
                    ]),
                */
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("ADD DATA"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    addData();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
