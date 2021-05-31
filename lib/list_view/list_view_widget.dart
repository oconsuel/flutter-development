import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListViewWidget extends StatefulWidget {
  ListViewWidget({Key key}) : super(key: key);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
    );
  }
}
