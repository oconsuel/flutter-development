// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TestHttp extends StatefulWidget {
  final String url;

  TestHttp({String url}) : url = url;

  @override
  State<StatefulWidget> createState() => TestHttpState();
} // TestHttp

class TestHttpState extends State<TestHttp> {
  final _formKey = GlobalKey<FormState>();
  List<String> post = List();
  String _url, _body;
  int _status; //initState

  void _getDataFromWeb() async {
    final response = await http.get(
        'https://weather.com/weather/tenday/l/Moscow+Moscow+Russia?canonicalCityId=7446d3d73423b587e3dcedb5bf4585152fe7719a5c9a58bf8fd4b5802ff8bded');
    dom.Document document = parser.parse(response.body);

    // final link2 = document.getElementsByClassName('entry-title');
    // final elements =
    //     document.getElementsByClassName('entry-header blog-entry-header');
    setState(() {
      // title = elements
      //     .map((element) => element.getElementsByTagName('a')[0].innerHtml)
      //     .toList();

      final content = document
          .getElementsByClassName('DailyContent--temp--_8DL5')[0]
          .innerHtml;
      post = [content];
      // link = link2
      //     .map((element) =>
      //         element.getElementsByTagName('a')[0].attributes['href'])
      //     .toList();
    });
  }

  @override
  void initState() {
    _url = widget.url;
    super.initState();
    _getDataFromWeb();
  }

  _sendRequestGet() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); //update form data

      http.get(_url).then((response) {
        _status = response.statusCode;
        _body = response.body;

        setState(() {}); //reBuildWidget
      }).catchError((error) {
        _status = 0;
        _body = error.toString();

        setState(() {}); //reBuildWidget
      });
    }
  } //_sendRequestGet

  _sendRequestPost() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); //update form data

      try {
        var response = await http.post(_url);

        _status = response.statusCode;
        _body = response.body;
      } catch (error) {
        _status = 0;
        _body = error.toString();
      }
      setState(() {}); //reBuildWidget
    }
  } //_sendRequestPost

  // //_sendRequestPost
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(children: [
          Form(
            key: _formKey,
            child: Column(children: [
              Container(
                  child: Text('API url',
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.purple[500])),
                  padding: EdgeInsets.all(10.0)),
              Container(
                  child: TextFormField(
                      initialValue: _url,
                      validator: (value) {
                        if (value.isEmpty) return 'API url isEmpty';
                      },
                      onSaved: (value) {
                        _url = value;
                      },
                      autovalidate: true),
                  padding: EdgeInsets.all(10.0)),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Send request GET'),
                onPressed: _sendRequestGet,
                color: Colors.deepPurple[800],
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(80))),
              ),
              RaisedButton(
                child: Text('Send request POST'),
                onPressed: _sendRequestPost,
                color: Colors.deepPurple[800],
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(80))),
              ),
              SizedBox(height: 20.0),
              Text('Response status',
                  style: TextStyle(fontSize: 20.0, color: Colors.purple[500])),
              Text(_status == null ? '' : _status.toString()),
              SizedBox(height: 20.0),
              // ListView.builder(
              //   padding: const EdgeInsets.all(8),
              //   itemCount: rty,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Text(rty[index]);
              //   },
              // ),

              Text('Response body',
                  style: TextStyle(fontSize: 20.0, color: Colors.purple[500])),
              SizedBox(height: 20.0),
              Text(
                _body == null ? '' : _body,
              ),
            ]),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: post.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                            child: FadeInAnimation(
                                child: Card(
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  post[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ))));
                  }),
            ),
          )
        ]));
  }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//             child: Column(
//           children: <Widget>[
//             Container(
//                 child: Text('API url',
//                     style:
//                         TextStyle(fontSize: 20.0, color: Colors.purple[500])),
//                 padding: EdgeInsets.all(10.0)),
//             Container(
//                 child: TextFormField(
//                     initialValue: _url,
//                     validator: (value) {
//                       if (value.isEmpty) return 'API url isEmpty';
//                     },
//                     onSaved: (value) {
//                       _url = value;
//                     },
//                     autovalidate: true),
//                 padding: EdgeInsets.all(10.0)),
//             SizedBox(height: 20.0),
//             RaisedButton(
//               child: Text('Send request GET'),
//               onPressed: _sendRequestGet,
//               color: Colors.deepPurple[800],
//               textColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(80))),
//             ),
//             RaisedButton(
//               child: Text('Send request POST'),
//               onPressed: _sendRequestPost,
//               color: Colors.deepPurple[800],
//               textColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(80))),
//             ),
//             SizedBox(height: 20.0),
//             Text('Response status',
//                 style: TextStyle(fontSize: 20.0, color: Colors.purple[500])),
//             Text(_status == null ? '' : _status.toString()),
//             SizedBox(height: 20.0),
//             // ListView.builder(
//             //   padding: const EdgeInsets.all(8),
//             //   itemCount: rty,
//             //   itemBuilder: (BuildContext context, int index) {
//             //     return Text(rty[index]);
//             //   },
//             // ),

//             Text('Response body',
//                 style: TextStyle(fontSize: 20.0, color: Colors.purple[500])),
//             SizedBox(height: 20.0),
//             Text(
//               _body == null ? '' : _body,
//             ),
//           ],
//         )));
//   } //build
// } //TestHttpState
}

class Story {
  String title;
  String dateAdded;

  Story(this.title, this.dateAdded);

  @override
  String toString() => '$title $dateAdded';
}
