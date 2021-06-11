import 'package:test_project/home_page/home_page_widget.dart';

import 'google_contact_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/flutter_flow/flutter_flow_theme.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn;
  GoogleSignInAccount _currentUser;
  GoogleContacts contacts;
  bool isLoading = false;

  Future getUserContacts() async {
    final host = "https://people.googleapis.com";
    final endPoint =
        "/v1/people/me/connections?personFields=names,phoneNumbers";
    final header = await _currentUser.authHeaders;

    setState(() {
      isLoading = true;
    });

    print("loading contact");
    final request = await http.get("$host$endPoint", headers: header);
    print("Loading completed");
    setState(() {
      isLoading = false;
    });

    if (request.statusCode == 200) {
      print("Api working perfect");
      setState(() {
        contacts = googleContactsFromJson(request.body);
      });
    } else {
      print("Api got error");
      print(request.body);
    }
  }

  @override
  initState() {
    super.initState();

    _googleSignIn = GoogleSignIn(scopes: [
      "https://www.googleapis.com/auth/contacts.readonly",
    ]);

    _googleSignIn.onCurrentUserChanged.listen((user) {
      setState(() {
        _currentUser = user;
      });

      if (user != null) {
        getUserContacts();
        print(_currentUser.displayName);
      }
    });
  }

  Widget getLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Загрузить список контактов",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
            onPressed: () async {
              try {
                await _googleSignIn.signIn();
              } on Exception catch (e) {
                print(e);
              }
            },
            child: Text("Загрузить"),
            color: FlutterFlowTheme.primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                // borderSide: BorderSide(
                //                                   color: Color(0xFF553BBA),
                //                                   width: 1,
                //                                 ),
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: Color(0xFF553BBA))))
      ],
    );
  }

  Widget getContactListWidget(context) {
    analytics.logEvent(name: "contacts_page");
    return ListView.separated(
      itemBuilder: (context, index) {
        final currentContact = contacts.connections[index];
        return ListTile(
          trailing: Icon(
            Icons.account_circle_outlined,
            color: Color(0xFF553BBA),
          ),
          title: Text(
            "${currentContact.names.first.displayName}",
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onTap: () {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Phone number is ${currentContact.phoneNumbers.first.value}")));
          },
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: contacts.connections.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _currentUser == null
          ? Container()
          : FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageWidget(),
                  ),
                );
              },
              child: Icon(Icons.logout),
              backgroundColor: Color(0xFF553BBA),
            ),
      appBar: AppBar(
        title: Text(
          "Контакты",
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF272727),
      ),
      backgroundColor: FlutterFlowTheme.primaryColor,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : contacts != null && _currentUser != null
                ? getContactListWidget(context)
                : getLoginWidget(),
      ),
    );
  }
}
