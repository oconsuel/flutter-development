import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class TestHttp extends StatefulWidget {
  final String url;

  TestHttp({String url}) : url = url;

  @override
  State<StatefulWidget> createState() => TestHttpState();
} // TestHttp

class TestHttpState extends State<TestHttp> {
  final _formKey = GlobalKey<FormState>();

  String _url, _body;
  int _status;

  @override
  void initState() {
    _url = widget.url;
    super.initState();
  } //initState

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

  _sendRequestGetTemp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        var response = await http.post(_url);
        var document = parse(response.body);
        print(document.getElementsByTagName("p").length);
      } catch (error) {}
    }
  }
  //_sendRequestPost

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
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
              onPressed: _sendRequestGetTemp,
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
            RaisedButton(
              child: Text('Send request TEMP'),
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
            Text('Response body',
                style: TextStyle(fontSize: 20.0, color: Colors.purple[500])),
            SizedBox(height: 20.0),
            Text(
              _body == null ? '' : _body,
            ),
          ],
        )));
  } //build
} //TestHttpState
