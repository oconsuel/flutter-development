import 'package:flutter/material.dart';

class FirstLabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Настроить приложение',
              style: TextStyle(fontSize: 35.0),
            ),
            SizedBox(
              height: 100,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new RaisedButton(
                  textColor: Colors.black,
                  color: Colors.purple[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Text('Посмотреть', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DetailScreen();
                      }),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Подробная информация'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Image.network(
                    'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp13touch-space-select-202005?wid=904&hei=840&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1587460552755',
                    width: 300,
                  ),
                  ListTile(
                    // leading: Icon(Icons.album),
                    title: Text('Macbook Pro 13, 2020'),
                    subtitle: Text(
                        'Intel Core i5,Turbo Boost up to 3.8GHz, 32GB, 1TB SSD'),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Назад'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
