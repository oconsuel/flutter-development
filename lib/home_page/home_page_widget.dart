// import 'package:test_project/8_lab/8_lab.dart';
import 'package:test_project/JWT/main.dart';
import 'package:test_project/chat/chat.dart';
import 'package:test_project/contacts/login_screen.dart';
import 'package:test_project/contacts/main.dart';

import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'dart:io';
import 'package:aes_crypt/aes_crypt.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics();

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

String encFilepath;
String decFilepath;
String srcFilepath;

class _HomePageWidgetState extends State<HomePageWidget> {
  final myController = TextEditingController();
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List data = ["Ожидание", "Расшифрован", "Зашифрован"];
  int i = 0;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: "home_page");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF272727),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'flutter dev',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0x00EEEEEE),
              ),
              alignment: Alignment(0, 0),
              child: Align(
                alignment: Alignment(0, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    alignment: Alignment(-0.050000000000000044, 0),
                    child: InkWell(
                      onTap: () async {
                        scaffoldKey.currentState.openDrawer();
                      },
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
        elevation: 4,
      ),
      backgroundColor: FlutterFlowTheme.primaryColor,
      drawer: Drawer(
        elevation: 16,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  currentUserPhoto,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          currentUserEmail,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Lato',
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 100),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentUserUid,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Lato',
                      ),
                    )
                  ],
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  await signOut();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainWidget(),
                    ),
                  );
                },
                text: 'Button',
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: new ListView(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: PageView(
                            controller: pageViewController,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MyApp3(),
                                            ),
                                          );
                                          analytics.logEvent(
                                              name: "get_contacts");
                                        },
                                        text: 'К контактам',
                                        options: FFButtonOptions(
                                          width: 150,
                                          height: 40,
                                          color: FlutterFlowTheme.primaryColor,
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFF553BBA),
                                            width: 1,
                                          ),
                                          borderRadius: 12,
                                        ),
                                      )
                                      // LoginScreen(),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(50, 0, 50, 0),
                                          child: TextFormField(
                                            controller: myController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Пароль для шифрования',
                                              labelStyle: FlutterFlowTheme
                                                  .bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Color(0x73553BBA),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFFCFCFC),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFFCFCFC),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0x73553BBA),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        _shif(context);
                                        print('Button pressed ...');
                                      },
                                      text: 'Зашифровать',
                                      icon: FaIcon(
                                        FontAwesomeIcons.download,
                                        color: Color(0xFF553BBA),
                                        size: 16,
                                      ),
                                      options: FFButtonOptions(
                                        width: 180,
                                        height: 40,
                                        color: FlutterFlowTheme.primaryColor,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                        borderSide: BorderSide(
                                          color: Color(0xFF553BBA),
                                          width: 1,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        _deshif(context);
                                        print('Button pressed ...');
                                      },
                                      text: 'Расшифровать',
                                      icon: FaIcon(
                                        FontAwesomeIcons.upload,
                                        color: Color(0xFF553BBA),
                                        size: 16,
                                      ),
                                      options: FFButtonOptions(
                                        width: 180,
                                        height: 40,
                                        color: FlutterFlowTheme.primaryColor,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                        borderSide: BorderSide(
                                          color: Color(0xFF553BBA),
                                          width: 1,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Text(
                                      'Статус - ' + data[i],
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  //   child: Text(
                                  //     'The decryption has been completed successfully. \n\n Decrypted file 2: $decFilepath \n\n File content: ' +
                                  //         File(decFilepath).readAsStringSync(),
                                  //     style:
                                  //         FlutterFlowTheme.bodyText1.override(
                                  //       fontFamily: 'Poppins',
                                  //       color: Colors.white,
                                  //       fontSize: 16,
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Lab07(),
                                            ),
                                          );
                                        },
                                        text: 'Go chat!',
                                        options: FFButtonOptions(
                                          width: 130,
                                          height: 40,
                                          color: FlutterFlowTheme.primaryColor,
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFF553BBA),
                                            width: 1,
                                          ),
                                          borderRadius: 12,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MyApp5(),
                                            ),
                                          );
                                        },
                                        text: 'Go JWT!',
                                        options: FFButtonOptions(
                                          width: 130,
                                          height: 40,
                                          color: FlutterFlowTheme.primaryColor,
                                          textStyle: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFF553BBA),
                                            width: 1,
                                          ),
                                          borderRadius: 12,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              // Column(
                              //   mainAxisSize: MainAxisSize.max,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Row(
                              //       mainAxisSize: MainAxisSize.max,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         FFButtonWidget(
                              //           // r
                              //           text: 'Go chat!',
                              //           options: FFButtonOptions(
                              //             width: 130,
                              //             height: 40,
                              //             color: FlutterFlowTheme.primaryColor,
                              //             textStyle: FlutterFlowTheme.subtitle2
                              //                 .override(
                              //               fontFamily: 'Poppins',
                              //               color: Colors.white,
                              //             ),
                              //             borderSide: BorderSide(
                              //               color: Color(0xFF553BBA),
                              //               width: 1,
                              //             ),
                              //             borderRadius: 12,
                              //           ),
                              //         )
                              //       ],
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, 1),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: SmoothPageIndicator(
                              controller: pageViewController,
                              count: 4,
                              axisDirection: Axis.horizontal,
                              onDotClicked: (i) {
                                pageViewController.animateToPage(
                                  i,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              effect: ExpandingDotsEffect(
                                expansionFactor: 2,
                                spacing: 8,
                                radius: 16,
                                dotWidth: 15,
                                dotHeight: 15,
                                dotColor: Color(0xFF9E9E9E),
                                activeDotColor: Color(0xFF553BBA),
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _shif(context) async {
    analytics.logEvent(name: "shif_file");
    final params = OpenFileDialogParams();
    final filePath = await FlutterFileDialog.pickFile(params: params);
    print(filePath);

    srcFilepath = filePath;

    print('Unencrypted source file: $srcFilepath');
    print('File content: ' + File(srcFilepath).readAsStringSync() + '\n');

    var crypt = AesCrypt();

    crypt.setPassword(myController.text);
    crypt.setOverwriteMode(AesCryptOwMode.warn);
    try {
      encFilepath = crypt.encryptFileSync(
          srcFilepath, '/storage/emulated/0/Download/encrypted.aes');
      print('The encryption has been completed successfully.');
      print('Encrypted file: $encFilepath');
      setState(() {
        i = (2) % data.length;
      });
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(
      //         'The encryption has been completed successfully. \n\n Encrypted file: $encFilepath')));
    } on AesCryptException catch (e) {
      if (e.type == AesCryptExceptionType.destFileExists) {
        print('The encryption has been completed unsuccessfully.');
        print(e.message);
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text(
        //         'The encryption has been completed unsuccessfully. \n\n' +
        //             e.message)));
      }
      return;
    }
  }

  void shifpos() async {
    analytics.logEvent(name: "shif_page");
  }

  void _deshif(context) async {
    final params = OpenFileDialogParams();
    final filePath = await FlutterFileDialog.pickFile(params: params);
    print(filePath);

    var crypt = AesCrypt();

    crypt.setPassword(myController.text);
    crypt.setOverwriteMode(AesCryptOwMode.warn);

    try {
      decFilepath = crypt.decryptFileSync(
          filePath, '/storage/emulated/0/Download/decrypted_new.txt');
      print('The decryption has been completed successfully.');
      print('Decrypted file 2: $decFilepath');
      print('File content: ' + File(decFilepath).readAsStringSync());

      setState(() {
        i = (1) % data.length;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Результат расшифровки файла $decFilepath : '),
        // File(decFilepath).readAsStringSync()),
        duration: Duration(seconds: 10),
      ));
    } on AesCryptException catch (e) {
      if (e.type == AesCryptExceptionType.destFileExists) {
        print('The decryption has been completed unsuccessfully.');
        print(e.message);
      }
    }
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
            'The decryption has been completed successfully. \n\n Decrypted file 2: $decFilepath \n\n File content: ' +
                File(decFilepath).readAsStringSync())));
  }
}
