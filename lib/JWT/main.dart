import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/JWT/model.dart';
import 'package:test_project/flutter_flow/flutter_flow_util.dart';
// import 'package:firebase_image/firebase_image.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics();
void main() {
  runApp(MyApp5());
}

class MyApp5 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp5> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final HttpClient client = HttpClient();
  String responseText = '';
  String responseTime = '';
  String token = '';
  Map jsonMap = {'username': 'user1', 'password': 'abcxyz'};

  List<Profile> userProfile = [];

  bool isloading = false;

  Future<void> sendData() async {
    setState(() {
      isloading = true;
    });
    await http.post(
        "https://flutterflow-test-4a05f-default-rtdb.europe-west1.firebasedatabase.app/userprofile.json",
        body: json.encode({
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
        }));
    setState(() {
      isloading = false;
    });
    setState(() {
      userProfile.add(Profile(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
      ));
    });
  }

  Future<void> fetchtheprofiles() async {
    final response = await http.get(
        "https://flutterflow-test-4a05f-default-rtdb.europe-west1.firebasedatabase.app/userprofile.json");
    print(json.decode(response.body));
    final List<Profile> loadedProfile = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((profileId, profileData) {
      loadedProfile.add(
        Profile(
          email: profileData['email'],
          lastName: profileData['firstName'],
          firstName: profileData['lastName'],
        ),
      );
    });
    userProfile = loadedProfile;
  }

  @override
  void initState() {
    fetchtheprofiles();

    super.initState();
  }

  Uint8List responseImage;

  void getJwt() {
    FirebaseAnalytics().logEvent(name: 'get_jwt', parameters: null);
    client
        .postUrl(Uri.parse('https://flutter-jwt-oconsuel.herokuapp.com//auth'))
        .then((HttpClientRequest request) {
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));
      print(request);
      return request.close();
    }).then((HttpClientResponse response) {
      response.listen((event) {
        String responseString = String.fromCharCodes(event);
        setState(() {
          token = json.decode(responseString)['access_token'];
          print(token);
        });
      });
    });
  }

  void getResp() {
    client
        .getUrl(
            Uri.parse('https://flutter-jwt-oconsuel.herokuapp.com/protected'))
        .then((HttpClientRequest request) {
      request.headers.set('Authorization', 'JWT $token');
      return request.close();
    }).then((HttpClientResponse response) {
      if (response.statusCode != 200) {
        response.listen((event) {
          String responseString = String.fromCharCodes(event);
          setState(() {
            responseText = responseString;
          });
        });
      } else {
        String gotResponse = '';
        response.forEach((element) {
          gotResponse += String.fromCharCodes(element);
        }).then((value) {
          var jsonDecoded = json.decode(gotResponse);
          String time = DateFormat.yMd()
              .add_jm()
              .format(DateTime.fromMicrosecondsSinceEpoch(
                  jsonDecoded['timestamp'].toInt() * 1000000))
              .toString();
          setState(() {
            responseText = '$time';
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: 'jwt_page');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("User Profile"),
            leading: Icon(
              Icons.verified_user,
              color: Colors.green,
            ),
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(getCurrentTimestamp.toString()),
                  ],
                ),
                ElevatedButton(
                  onPressed: getJwt,
                  child: Text('Получить JWT'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF272727),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Text(token, textAlign: TextAlign.left),
                ElevatedButton(
                  onPressed: getResp,
                  child: Text('Получить время сервера'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF272727),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Text(responseText),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/flutterflow-test-4a05f.appspot.com/o/oconsuel_logo.jpg?alt=media&token=5e0c1b19-339f-4fe6-954e-53bdc5181421',
                  width: 100,
                  height: 200,
                )
              ],
            ),
            // Column(
            //   children: <Widget>[
            //     Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //       Text(getCurrentTimestamp.toString()),
            //     ])
            // TextField(
            //   controller: firstNameController,
            //   decoration: InputDecoration(labelText: 'First Name'),
            // ),
            // TextField(
            //   controller: lastNameController,
            //   decoration: InputDecoration(labelText: 'Last Name'),
            // ),
            // TextField(
            //   controller: emailController,
            //   decoration: InputDecoration(labelText: 'email'),
            // ),
            // Text(getCurrentTimestamp.toString()),
            // // isloading
            // //     ? CircularProgressIndicator()
            // //     : FlatButton(
            // //         child: Text("Send"),
            // //         color: Colors.indigo,
            // //         onPressed: sendData,
            // //       ),
            // // Container(
            // //   child: Column(
            // //     children: userProfile
            // //         .map((ctx) => Profile(
            // //               firstName: ctx.firstName,
            // //               lastName: ctx.lastName,
            // //               email: ctx.email,
            // //             ))
            // //         .toList(),
            // //   ),
            // )
            // ],
          ),
        ));
  }
}
