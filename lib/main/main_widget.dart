import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_page/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics();

class MainWidget extends StatefulWidget {
  MainWidget({Key key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: "login_page");
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF272727),
        automaticallyImplyLeading: false,
        title: Text(
          'Login page',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFF121212),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.primaryColor,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0, 2.08),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: Container(
                                width: 285,
                                height: 40,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0, 0),
                                      child: TextFormField(
                                        controller: emailTextController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Username',
                                          hintStyle: GoogleFonts.getFont(
                                            'Lato',
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF3C2452),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF3C2452),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: GoogleFonts.getFont(
                                          'Lato',
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.95, 0.5),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: Container(
                                width: 285,
                                height: 40,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(0, 0),
                                      child: TextFormField(
                                        controller: passwordTextController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: GoogleFonts.getFont(
                                            'Lato',
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF3C2452),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF3C2452),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: GoogleFonts.getFont(
                                          'Lato',
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment(0.95, 0.5),
                                      child: Icon(
                                        Icons.lock_open,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 35, 0),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: 'Sign up',
                                      options: FFButtonOptions(
                                        width: 125,
                                        height: 40,
                                        color: Color(0x00FFFFFF),
                                        textStyle: GoogleFonts.getFont(
                                          'Lato',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        borderSide: BorderSide(
                                          color: Color(0xFF553BBA),
                                          width: 2,
                                        ),
                                        borderRadius: 0,
                                      ),
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      final user =
                                          await signInWithGoogle(context);
                                      analytics.logLogin();
                                      analytics.setUserProperty(
                                          name: 'rank', value: 'gold');
                                      if (user == null) {
                                        return;
                                      }
                                      await Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomePageWidget(),
                                        ),
                                        (r) => false,
                                      );
                                    },
                                    text: 'Google',
                                    options: FFButtonOptions(
                                      width: 125,
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: GoogleFonts.getFont(
                                        'Lato',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      borderSide: BorderSide(
                                        color: Color(0xFF553BBA),
                                        width: 2,
                                      ),
                                      borderRadius: 0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      final user = await signInWithEmail(
                                        context,
                                        emailTextController.text,
                                        passwordTextController.text,
                                      );
                                      if (user == null) {
                                        return;
                                      }

                                      await Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomePageWidget(),
                                        ),
                                        (r) => false,
                                      );
                                    },
                                    text: 'Sign in',
                                    options: FFButtonOptions(
                                      width: 125,
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: GoogleFonts.getFont(
                                        'Lato',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      borderSide: BorderSide(
                                        color: Color(0xFF553BBA),
                                        width: 2,
                                      ),
                                      borderRadius: 0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              'Forgot Password?',
                              style: GoogleFonts.getFont(
                                'Lato',
                                color: Color(0xFF676767),
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
