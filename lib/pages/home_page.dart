import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/ob/dog_ob.dart';
import 'package:flutter_gallery_saver/flutter_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imgURL = '';
  var requestURL = Uri.parse("https://dog.ceo/api/breeds/image/random");
  bool isLoad = false;

  var _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: imgURL.isEmpty ? null : getDownload,
            icon: Icon(Icons.download),
          ),
        ],
        backgroundColor: Colors.green,
        centerTitle: false,
        title: Text("Random Image Downloader"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Center(
            child: isLoad
                ? CircularProgressIndicator()
                : imgURL.isEmpty
                    ? Text('Nothing')
                    : Image.network(imgURL),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: getRandomImage,
            child: Text(
              "Get Random Dog Image",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  getDownload() async {
    var status = await Permission.storage.status;

    if (status == PermissionStatus.granted) {
      var response = await Dio()
          .get(imgURL, options: Options(responseType: ResponseType.bytes));
      final result = await FlutterGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          albumName: "hello");

      _scaffoldkey.currentState.showBottomSheet((context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            width: double.infinity,
            height: 100,
            child: Center(child: Text('Save Successfully')),
          ),
        );
      }, backgroundColor: Colors.green);
    } else {
      await Permission.storage.request();
    }
  }

  getRandomImage() async {
    setState(() {
      isLoad = true;
    });
    var response = await http.get(requestURL);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      // print(map['message']);
      DogOb dob = DogOb.fromMap(map);
      setState(() {
        isLoad = false;
        imgURL = dob.message;
      });
    } else {
      setState(() {
        isLoad = false;
      });
      print('Error');
    }
  }
}
