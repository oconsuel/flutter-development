import 'package:flutter/material.dart';
import 'package:lab_1/labs/FirstLab.dart';
import 'package:lab_1/labs/SecondLab.dart';
import 'package:lab_1/labs/ThirdLab.dart';
import 'package:lab_1/utils/constants.dart';
import 'package:lab_1/utils/themes.dart';

void main() => runApp(ScreenWidget());

class ScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: basicTheme(),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Flutter project",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: LargeTextSize)
                  .copyWith(color: Colors.purple[500])
                  .copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.purple[50],
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.purple[500],
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(text: "Lab 1"),
                Tab(text: "Lab 2"),
                Tab(text: "Lab 3"),
              ],
            ),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: [
          //     BottomNavigationBarItem(
          //       title: Text('Favorites'),
          //       icon: Icon(Icons.favorite),
          //     ),
          //     BottomNavigationBarItem(
          //       title: Text('Music'),
          //       icon: Icon(Icons.music_note),
          //     ),
          //     BottomNavigationBarItem(
          //       title: Text('Places'),
          //       icon: Icon(Icons.),
          //     ),
          //     BottomNavigationBarItem(
          //       title: Text('News'),
          //       icon: Icon(Icons.library_books),
          //     ),
          //   ],
          // ),
          body: TabBarView(
            children: <Widget>[FirstLabs(), SecondLabs(), ThirdLabs()],
          ),
        ),
      ),
    );
  }
}
