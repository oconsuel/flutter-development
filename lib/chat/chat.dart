import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:test_project/flutter_flow/flutter_flow_theme.dart';
import 'package:test_project/home_page/home_page_widget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:web_socket_channel/status.dart' as status;
import 'package:bubble/bubble.dart';

ScrollController _scrollController = new ScrollController();
const String defaultUserName = "oconsuel";

class Lab07 extends StatefulWidget {
  @override
  _Lab07State createState() => _Lab07State();
}

class _Lab07State extends State<Lab07> {
  final TextEditingController textEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                filled: true,
                border: InputBorder.none,
                hintText: 'Как вас зовут?',
              ),
            ),
            ElevatedButton(
              child: Text('Войти'),
              onPressed: _createUser,
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF272727), // background
                onPrimary: Colors.white,

                // foreground
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createUser() {
    final User user = new User(
        name: textEditingController.text,
        imageUrl: '',
        color: Color(0xFF553BBA));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Provider<User>(
          create: (_) => user,
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  brightness: Brightness.dark,
                  primaryColor: Color(0xFF553BBA),
                  accentColor: Color(0xFF553BBA),
                  unselectedWidgetColor: Color(0xFF553BBA)),
              home: HomeScreen()),
        ),
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function onPressed;

  MessageInput({@required this.textEditingController, this.onPressed});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 9,
            child: TextField(
              controller: widget.textEditingController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: 'Отправить сообщение...'),
            ),
          ),
          Flexible(
            child: IconButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).primaryColorDark,
              icon: Icon(Icons.send),
              onPressed: widget.onPressed,
            ),
          )
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final List<Message> messages;

  MessageList({this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      controller: _scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) => MessageItem(message: messages[index]),
    );
  }
}

class MessageItem extends StatelessWidget {
  final Message message;

  MessageItem({@required this.message});

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    // return Row(
    //   children: [
    //     new CircleAvatar(
    //       child: new Text(defaultUserName[0]),
    //       backgroundColor: Color(0x73553BBA),
    //     ),
    return Bubble(
      color: Color(0x73553BBA),
      alignment: message.author.name == user.name
          ? Alignment.topRight
          : Alignment.topLeft,
      // color: message.author.color,
      elevation: 1 * px,
      margin: BubbleEdges.only(bottom: 15.0),
      child: Text(
        message.body,
        style: TextStyle(fontSize: 20),
      ),
    );
    //   ],
    // );
  }
}

class Message {
  String id;
  User author;
  String body;

  Message({this.id, this.author, this.body});

  factory Message.fromJson(Map<String, dynamic> json) => new Message(
      id: json['id'],
      author: User.fromJson(json['author']),
      body: json['body']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'author': author.toJson(), 'body': body};
}

class User {
  String name;
  String imageUrl;
  Color color;

  User({this.name, this.imageUrl, this.color});

  factory User.fromJson(Map<String, dynamic> json) => new User(
      name: json['name'],
      imageUrl: json['imageUrl'],
      color: hexToColor(json['color']));

  Map<String, dynamic> toJson() =>
      {'name': name, 'imageUrl': imageUrl, 'color': colorToHex(color)};
}

// Color of the format #RRGGBB.
Color hexToColor(String code) =>
    new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

String colorToHex(Color color) => '#${color.value.toRadixString(16)}';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final IOWebSocketChannel channel =
      IOWebSocketChannel.connect('wss://chtik-botik.herokuapp.com/');

  final TextEditingController _textEditingController =
      new TextEditingController();

  List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  print(context);
                  print('serv:');
                  print(snapshot.data);
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.data == null) {
                    return Center(child: Text('Начните диалог!'));
                  } else {
                    Message message =
                        Message.fromJson(jsonDecode(snapshot.data));
                    if (messages.isEmpty) {
                      messages.insert(0, message);
                    } else {
                      if (message.id != messages.first.id) {
                        messages.insert(0, message);
                      }
                    }
                  }
                  return MessageList(messages: messages);
                },
              ),
            ),
            Expanded(
              child: MessageInput(
                textEditingController: _textEditingController,
                onPressed: _sendMessage,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  void _sendMessage() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 3000),
    );
    final User user = Provider.of<User>(context, listen: false);

    final messageBody = _textEditingController.text;

    final Message message =
        new Message(id: new Uuid().v1(), author: user, body: messageBody);
    final jsonMessage = jsonEncode(message);

    print('client');
    print(jsonMessage);
    messages.insert(0, message);

    channel.sink.add(jsonMessage);

    _textEditingController.clear();
  }
}
// const String defaultUserName = "oconsuel";
// const String defaultServerName = "server";

// void main() => runApp(new MyApp1());

// class MyApp1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext ctx) {
//     return new MaterialApp(
//       title: "Chat Application",
//       home: new Chat(
//         channel: new IOWebSocketChannel.connect("ws://echo.websocket.org"),
//       ),
//     );
//   }
// }

// class Chat extends StatefulWidget {
//   final WebSocketChannel channel;
//   Chat({@required this.channel});
//   @override
//   State createState() => new ChatWindow();
// }

// class ChatWindow extends State<Chat> with TickerProviderStateMixin {
//   final List<Msg> _messages = <Msg>[];
//   final TextEditingController _textController = new TextEditingController();
//   bool _isWriting = false;

//   @override
//   Widget build(BuildContext ctx) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: InkWell(
//           onTap: () async {
//             await Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => HomePageWidget()));
//           },
//           child: Text(
//             "Chat Application",
//             style: FlutterFlowTheme.title1.override(
//               fontFamily: 'Poppins',
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         backgroundColor: Color(0xFF272727),
//       ),
//       backgroundColor: FlutterFlowTheme.primaryColor,
//       body: new Column(children: <Widget>[
//         new Flexible(
//             child: new ListView.builder(
//           itemBuilder: (_, int index) => _messages[index],
//           itemCount: _messages.length,
//           reverse: true,
//           padding: new EdgeInsets.all(6.0),
//         )),
//         new Divider(height: 1.0),
//         new Container(
//           child: _buildComposer(),
//         ),
//       ]),
//     );
//   }

//   Widget _buildComposer() {
//     return new IconTheme(
//       data: new IconThemeData(color: Theme.of(context).accentColor),
//       child: new Container(
//         margin: const EdgeInsets.symmetric(horizontal: 9.0),
//         child: new Row(
//           children: <Widget>[
//             new Flexible(
//               child: new TextField(
//                 style: TextStyle(color: Colors.white),
//                 cursorColor: Color(0x73553BBA),
//                 controller: _textController,
//                 onChanged: (String txt) {
//                   setState(() {
//                     _isWriting = txt.length > 0;
//                   });
//                 },
//                 onSubmitted: submitMsg,
//                 decoration: new InputDecoration.collapsed(
//                   hintText: "Введите текст сообщения",
//                   hintStyle: FlutterFlowTheme.bodyText1.override(
//                     fontFamily: 'Poppins',
//                     color: Color(0x73553BBA),
//                   ),
//                 ),
//               ),
//             ),
//             new Container(
//                 margin: new EdgeInsets.symmetric(horizontal: 3.0),
//                 child: new IconButton(
//                     icon: new Icon(
//                       Icons.message,
//                       color: Color(0x73553BBA),
//                     ),
//                     onPressed: () {
//                       submitMsg(_textController.text);
//                       new StreamBuilder(
//                         stream: widget.channel.stream,
//                         builder: (context, snapshot) {
//                           return GiveResponse(snapshot.data);
//                         },
//                       );
//                     } // : null,
//                     )),
//           ],
//         ),
//       ),
//     );
//   }

//   GiveResponse(AsyncSnapshot snapshot) {}

//   void submitMsg(String txt) {
//     _textController.clear();
//     widget.channel.sink.add(_textController.text);
//     setState(() {
//       _isWriting = false;
//     });
//     Msg msg = new Msg(
//       txt: txt,
//       animationController: new AnimationController(
//           vsync: this, duration: new Duration(milliseconds: 800)),
//     );
//     setState(() {
//       _messages.insert(0, msg);
//     });
//     msg.animationController.forward();
//   }

//   @override
//   void dispose() {
//     for (Msg msg in _messages) {
//       msg.animationController.dispose();
//     }
//     widget.channel.sink.close();
//     super.dispose();
//   }
// }

// // class MyHomePage extends StatefulWidget {
// //   final WebSocketChannel channel;
// //   MyHomePage({@required this.channel});

// //   @override
// //   MyHomePageState createState() {
// //     return new MyHomePageState();
// //   }
// // }

// // class MyHomePageState extends State<MyHomePage> {
// //   TextEditingController editingController = new TextEditingController();
// //   @override
// //   Widget build(BuildContext context) {
// //     return new Scaffold(
// //       body: new Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: new Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: <Widget>[
// //             new StreamBuilder(
// //               stream: widget.channel.stream,
// //               builder: (context, snapshot) {
// //                 return new Padding(
// //                   padding: const EdgeInsets.all(20.0),
// //                   child: new Text(snapshot.hasData ? '${snapshot.data}' : ''),
// //                 );
// //               },
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// class Msg extends StatelessWidget {
//   Msg({this.txt, this.animationController});
//   final String txt;
//   final AnimationController animationController;

//   @override
//   Widget build(BuildContext ctx) {
//     return new SizeTransition(
//         sizeFactor: new CurvedAnimation(
//             parent: animationController, curve: Curves.easeOut),
//         axisAlignment: 0.0,
//         child: Column(children: [
//           new Container(
//             margin: const EdgeInsets.symmetric(vertical: 8.0),
//             child: new Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 new Container(
//                   margin: const EdgeInsets.only(right: 18.0),
//                   child: new CircleAvatar(
//                     child: new Text(defaultUserName[0]),
//                     backgroundColor: Color(0x73553BBA),
//                   ),
//                 ),
//                 new Expanded(
//                   child: new Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       new Text(defaultUserName,
//                           style: FlutterFlowTheme.bodyText1.override(
//                             fontFamily: 'Poppins',
//                             color: Colors.white,
//                           )),
//                       new Container(
//                         margin: const EdgeInsets.only(top: 6.0),
//                         child: new Text(
//                           txt,
//                           style: FlutterFlowTheme.bodyText1.override(
//                             fontFamily: 'Poppins',
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           new Container(
//             margin: const EdgeInsets.symmetric(vertical: 8.0),
//             child: new Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                 new Container(
//                   margin: const EdgeInsets.only(right: 18.0),
//                   child: new CircleAvatar(
//                       child: new Text(defaultServerName[0]),
//                       backgroundColor: Color(0x73553BBA)),
//                 ),
//                 new Expanded(
//                   child: new Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       new Text(
//                         defaultServerName,
//                         style: FlutterFlowTheme.bodyText1.override(
//                           fontFamily: 'Poppins',
//                           color: Colors.white,
//                         ),
//                       ),
//                       new Container(
//                         margin: const EdgeInsets.only(top: 6.0),
//                         child: new Text(
//                           'Ответ от сервера!',
//                           style: FlutterFlowTheme.bodyText1.override(
//                             fontFamily: 'Poppins',
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ]));
//   }
// }
