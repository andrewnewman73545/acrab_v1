import 'dart:io';
import 'dart:math';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:hb_check_code/hb_check_code.dart';
import 'package:json_form_generator/json_form_generator.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'dart:convert' show json;

class AddNewPersonPage extends StatefulWidget {
  String adaappbar;

  AddNewPersonPage({
    Key key,
    @required this.adaappbar,
    // @required this.store,
  }) : super(key: key);

  @override
  _AddNewPersonPageState createState() => _AddNewPersonPageState();
}

class _AddNewPersonPageState extends State<AddNewPersonPage>
    with SingleTickerProviderStateMixin {
  Image pickedImage;
  var pickedImage2;

  //Dio dio; // with default Options
  String namafile;
  String code;
  String emailxx = "";
  int cekemail = 0;

  File tmpFile;
  String base64Image;

  RegExp regEmail = new RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  RegExp regPhone = new RegExp(
    r'(^(?:[+]{1})?[0-9]{10,13}$)',
  );

  RegExp regTahun = new RegExp(
    r'(^(19|2[0-9])\d{2}$)',
  );

  dynamic response;
  dynamic responsex;

  var _formkey = GlobalKey<FormState>();

  String form = json.encode([
    {
      "title": "captcha",
      "label": "Spamcek angka diatas ini",
      "type": "text",
      "required": "yes"
    },
    {
      "title": "name",
      "label": "Nama Lengkap Sesuai KTP",
      "type": "text",
      "required": "yes"
    },
    {
      "title": "tgllahir",
      "label": "Tanggal Lahir",
      "type": "date",
      "required": "yes"
    },
    {
      'title': 'kelamin',
      'type': 'radio',
      'label': 'Kelamin',
      'items': ["PRIA", "WANITA"],
    },
    {
      "title": "nohp",
      "label": "No.HP yang aktif diawali +62 tanpa 0",
      "type": "text",
      "required": "yes"
    },
    {
      "title": "email",
      "label": "Email yang aktif",
      "type": "text",
      "required": "yes"
    },
    {
      "title": "groupbc",
      "label": "Kelompok Group",
      "type": "text",
      "required": "yes"
    }
  ]);

  Map initValue = {};

  @override
  void initState() {
    super.initState();

    code = "";
    //mau berapa digit
    for (var i = 0; i < 4; i++) {
      code = code + Random().nextInt(9).toString();
    }
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
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(children: <Widget>[
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
              Container(
                alignment: Alignment.center,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: new Text("Tambah Data yang berulang Tahun"),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: HBCheckCode(
                      width: width,
                      code: code,
                    )),
              ),
              JsonFormGenerator(
                initValue: initValue,
                form: form,
                onChanged: (dynamic value) {
                  print(value);
                  setState(() {
                    this.response = value;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: width,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: new Text('SUBMIT DATA'),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        if (regEmail.hasMatch(this.response['email'])) {
                        } else {
                          _showAlert(false, "Email", "Salah");
                          return;
                        }

                        if (regPhone.hasMatch(this.response['nohp'])) {
                        } else {
                          _showAlert(false, "NoHp",
                              "Salah, wajib diawali +, min 10 digit");
                          return;
                        }

                        if (code == this.response['captcha']) {
                        } else {
                          _showAlert(false, "Captcha", "Salah");
                          return;
                        }

                        //

                        var url = "http://sahabatsehati.org/tambahultah.php";
                        print(url);

                        print(this.response['tgllahir']);

                        String newhari = this
                            .response['tgllahir']
                            .substring(this.response['tgllahir'].length - 2);
                        print(newhari);

                        String newtahun =
                            this.response['tgllahir'].substring(0, 4);
                        print(newtahun);

                        String newbln =
                            this.response['tgllahir'].substring(5, 7);

                        print(newbln);
                        var data = this.response;

                        data.addAll({
                          'hari': newhari,
                          'bln': newbln,
                          'tahun': newtahun
                        });

                        print(json.encode(data));

                        responsex = await http.post(
                          url,
                          headers: {"Content-Type": "application/json"},
                          body: json.encode(data),
                        );

                        if (responsex.body.toString().contains("SUKSES")) {
                          _showsukses(true, "Penyimpanan", responsex.body);

                          _formkey.currentState.reset();

                          setState(() {
                            pickedImage = null;
                          });
                        } else {
                          _showAlert(false, "Penyimpanan", responsex.body);
                        }
                      }
                    }),
              ),
              SizedBox(
                height: 40,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
