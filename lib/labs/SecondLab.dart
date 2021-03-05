import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_1/utils/themes.dart';
import 'package:lab_1/labs/SecondLab/home_screen.dart';
import 'package:lab_1/labs/SecondLab/camera.dart';

class SecondLabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: basicTheme(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SelectAStatus(),
      },
    );
  }
}

class SelectAStatus extends StatefulWidget {
  @override
  _SelectAStatusState createState() => _SelectAStatusState();
}

class _SelectAStatusState extends State<SelectAStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          new SizedBox(height: 20.0),
          Text('Выберите функцию', style: TextStyle(fontSize: 20.0)),
          SelectStatusWidget(),
        ],
      )),
    );
  }
}

enum Status { stayhere, checkvideo, checkcamera }

class SelectStatusWidget extends StatefulWidget {
  SelectStatusWidget({Key key}) : super(key: key);

  @override
  _SelectStatusWidgetState createState() => _SelectStatusWidgetState();
}

bool navigateToPage = false;

class _SelectStatusWidgetState extends State<SelectStatusWidget> {
  Status _status = Status.stayhere;
  final TextEditingController _StatusOthersController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<Status>(
          title: const Text('Остаться здесь'),
          value: Status.stayhere,
          groupValue: _status,
          onChanged: (value) {
            setState(() {
              navigateToPage = true;
            });

            if (navigateToPage) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyApp2();
              }));
            }
          },
        ),
        RadioListTile<Status>(
          title: const Text('Просмотр видео'),
          value: Status.checkvideo,
          groupValue: _status,
          onChanged: (value) {
            setState(() {
              navigateToPage = true;
            });

            if (navigateToPage) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyApp();
              }));
            }
          },
        ),
        RadioListTile<Status>(
            title: const Text('Камера'),
            value: Status.checkcamera,
            groupValue: _status,
            onChanged: (value) {
              setState(() {
                navigateToPage = true;
              });

              if (navigateToPage) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyApp2();
                }));
              }
            }),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      home: VideoPlayer(),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      home: CameraApp(),
    );
  }
}
