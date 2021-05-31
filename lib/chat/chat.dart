import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:test_project/flutter_flow/flutter_flow_theme.dart';
import 'package:test_project/home_page/home_page_widget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

const String defaultUserName = "oconsuel";
const String defaultServerName = "server";

void main() => runApp(new MyApp1());

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return new MaterialApp(
      title: "Chat Application",
      home: new Chat(
        channel: new IOWebSocketChannel.connect("ws://echo.websocket.org"),
      ),
    );
  }
}

class Chat extends StatefulWidget {
  final WebSocketChannel channel;
  Chat({@required this.channel});
  @override
  State createState() => new ChatWindow();
}

class ChatWindow extends State<Chat> with TickerProviderStateMixin {
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;

  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      appBar: new AppBar(
        title: InkWell(
          onTap: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePageWidget()));
          },
          child: Text(
            "Chat Application",
            style: FlutterFlowTheme.title1.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color(0xFF272727),
      ),
      backgroundColor: FlutterFlowTheme.primaryColor,
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
          reverse: true,
          padding: new EdgeInsets.all(6.0),
        )),
        new Divider(height: 1.0),
        new Container(
          child: _buildComposer(),
        ),
      ]),
    );
  }

  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 9.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0x73553BBA),
                controller: _textController,
                onChanged: (String txt) {
                  setState(() {
                    _isWriting = txt.length > 0;
                  });
                },
                onSubmitted: submitMsg,
                decoration: new InputDecoration.collapsed(
                  hintText: "Введите текст сообщения",
                  hintStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Color(0x73553BBA),
                  ),
                ),
              ),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 3.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.message,
                      color: Color(0x73553BBA),
                    ),
                    onPressed: () {
                      submitMsg(_textController.text);
                      new StreamBuilder(
                        stream: widget.channel.stream,
                        builder: (context, snapshot) {
                          return GiveResponse(snapshot.data);
                        },
                      );
                    } // : null,
                    )),
          ],
        ),
      ),
    );
  }

  GiveResponse(AsyncSnapshot snapshot) {}

  void submitMsg(String txt) {
    _textController.clear();
    widget.channel.sink.add(_textController.text);
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 800)),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    widget.channel.sink.close();
    super.dispose();
  }
}

// class MyHomePage extends StatefulWidget {
//   final WebSocketChannel channel;
//   MyHomePage({@required this.channel});

//   @override
//   MyHomePageState createState() {
//     return new MyHomePageState();
//   }
// }

// class MyHomePageState extends State<MyHomePage> {
//   TextEditingController editingController = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: new Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             new StreamBuilder(
//               stream: widget.channel.stream,
//               builder: (context, snapshot) {
//                 return new Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: new Text(snapshot.hasData ? '${snapshot.data}' : ''),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: Column(children: [
          new Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 18.0),
                  child: new CircleAvatar(
                    child: new Text(defaultUserName[0]),
                    backgroundColor: Color(0x73553BBA),
                  ),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(defaultUserName,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          )),
                      new Container(
                        margin: const EdgeInsets.only(top: 6.0),
                        child: new Text(
                          txt,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 18.0),
                  child: new CircleAvatar(
                      child: new Text(defaultServerName[0]),
                      backgroundColor: Color(0x73553BBA)),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        defaultServerName,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 6.0),
                        child: new Text(
                          'Ответ от сервера!',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
