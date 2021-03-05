import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_knob/flutter_knob.dart';

class FirstLabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Настроить пользователя',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 30.0)
                  .copyWith(color: Colors.white)
                  .copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 100,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new RaisedButton(
                  padding: EdgeInsets.all(20),
                  textColor: Colors.white,
                  color: Colors.deepPurple[800],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Text('Посмотреть', style: TextStyle(fontSize: 20.0)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return new MyFor();
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

enum GenderList { male, female }

class MyFor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyForm();
}

class MyForm extends State {
  final _formKey = GlobalKey<FormState>();
  GenderList _gender;
  bool _agreement = false;
  double _value = 0;
  void _setValue(double value) => setState(() => _value = value);
  static const double minValue = 0;
  static const double maxValue = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Изменение профиля",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 25.0)
                .copyWith(color: Colors.purple[500])
                .copyWith(
                  fontWeight: FontWeight.bold,
                ),
          )),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),
          children: [
            Center(
                child: new Form(
              key: _formKey,
              child: new Column(
                children: <Widget>[
                  new SizedBox(height: 20.0),
                  new Text(
                    'Имя пользователя:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  new SizedBox(height: 10.0),
                  new TextFormField(
                    decoration: InputDecoration(labelText: 'Full name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Пожалуйста введите свое имя';
                      }
                      return null;
                    },
                  ),
                  new SizedBox(height: 20.0),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            new Text(
                              'Ваш пол:',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            RadioListTile(
                              activeColor: Colors.purple,
                              title: const Text('Мужской'),
                              value: GenderList.male,
                              groupValue: _gender,
                              onChanged: (GenderList value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            RadioListTile(
                              activeColor: Colors.purple,
                              title: const Text('Женский'),
                              value: GenderList.female,
                              groupValue: _gender,
                              onChanged: (GenderList value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(),
                      Expanded(
                        child: Column(
                          children: [
                            new Text(
                              'Ваш возраст:',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(
                              width: 100,
                              height: 110,
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                    axisLineStyle: AxisLineStyle(
                                        thickness: 0.2,
                                        thicknessUnit: GaugeSizeUnit.factor),
                                    showTicks: false,
                                    showLabels: false,
                                    radiusFactor: 1,
                                    pointers: <GaugePointer>[
                                      RangePointer(
                                          value: _value,
                                          width: 0.2,
                                          sizeUnit: GaugeSizeUnit.factor,
                                          color: Color(0XFF6A1B9A)),
                                      MarkerPointer(
                                        value: _value - 2,
                                        color: Colors.white,
                                        markerHeight: 5,
                                        markerWidth: 5,
                                        markerType: MarkerType.circle,
                                      ),
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          widget: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                '${_value.toStringAsFixed(0)}', // 'Value: ${_value.toStringAsFixed(3)}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Times',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0XFFCE93D8)),
                                              ),
                                              Text(
                                                ' years',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Times',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0XFFCE93D8)),
                                              )
                                            ],
                                          ),
                                          positionFactor: 0.13,
                                          angle: 0)
                                    ])
                              ]),
                            ),
                            SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  valueIndicatorColor: Colors
                                      .blue, // This is what you are asking for
                                  inactiveTrackColor:
                                      Colors.grey, // Custom Gray Color
                                  activeTrackColor: Colors.purple,
                                  thumbColor: Colors.white,
                                  overlayColor: Color(
                                      0x29EB1555), // Custom Thumb overlay Color
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 10.0),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 15.0),
                                ),
                                child: Slider(
                                  value: _value,
                                  onChanged: _setValue,
                                  min: minValue,
                                  max: maxValue,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(height: 20.0),
                  new CheckboxListTile(
                      activeColor: Colors.purple,
                      value: _agreement,
                      title: new Text('Я ознакомлен(a) с изменениями'),
                      onChanged: (bool value) =>
                          setState(() => _agreement = value)),
                  new SizedBox(height: 20.0),
                  new RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Color color = Colors.deepPurple[300];
                        String text;

                        if (_gender == null)
                          text = 'Выберите свой пол';
                        else if (_agreement == false)
                          text = 'Необходимо подтвердить согласие';
                        else {
                          text = 'Форма успешно заполнена';
                          color = Colors.deepPurple;
                          Navigator.pop(context);
                        }

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(text),
                          backgroundColor: color,
                        ));
                      }
                    },
                    padding: EdgeInsets.all(20),
                    child:
                        Text('Подтвердить', style: TextStyle(fontSize: 20.0)),
                    color: Colors.deepPurple[800],
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(80))),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
