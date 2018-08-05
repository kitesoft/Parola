import 'dart:async';

import 'package:final_parola/main.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//   StreamSubscription _scanSubscription;

//   Beacons.loggingEnabled = true;
//  Beacons.configure(BeaconsSettings(
//      android: BeaconsSettingsAndroid(logs: BeaconsSettingsAndroidLogs.info),
//      iOS: BeaconsSettingsIOS()));
//  // _scanSubscription.cancel();
  @override
  @override
  void initState() {
    getNames();

    // TODO: implement initState
    super.initState();
  }

  static String username = "", userid = "", useremail = "", userphotoURL = "";
  Future<Null> getNames() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? "";
      userid = prefs.getString("userid") ?? "";
      useremail = prefs.getString("useremail") ?? "";
      userphotoURL = prefs.getString("userphotoURL") ?? "";
    });
  }

  ///Extract Widgets to become readable code.
  Widget _kUserDrawer = UserAccountsDrawerHeader(
    accountName: Text(username),
    accountEmail: Text(useremail),
    currentAccountPicture: CircleAvatar(
      backgroundImage: userphotoURL == '' ? null : NetworkImage(userphotoURL),
    ),
    key: Key(userid),
  );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onExit,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(FontAwesomeIcons.bluetoothB),
          onPressed: () {},
          label: Text("Join Event"),
          backgroundColor: Colors.red[800],
        ),
        backgroundColor: Colors.red[400],
        appBar: AppBar(
          title: CircleAvatar(
              child: SvgPicture.asset(
                'assets/lighthouse.svg',
                height: 32.0,
                width: 32.0,
              ),
              maxRadius: 32.0,
              backgroundColor: Colors.red[400]),
          elevation: 0.0,
          backgroundColor: Colors.red[400],
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              color: Colors.black,
              splashColor: Colors.red[400],
              icon: Icon(
                Icons.search,
                size: 32.0,
              ),
              onPressed: () {},
            )
          ],
        ),
        drawer: Drawer(
          semanticLabel: "Open Settings",
          elevation: 0.0,
          child: ListView(
            children: <Widget>[
              _kUserDrawer,
              ListTile(
                title: Text("Exit"),
                leading: Icon(Icons.exit_to_app),
                onTap: () => _signOutGoogle(),
              ),
              AboutListTile()
            ],
          ),
        ),
        body: HBodyPage(),
      ),
    );
  }

  Future<bool> _onExit() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Exit Parola?"),
              content: Text("Do you want to exit Parola?"),
              actions: <Widget>[
                RaisedButton(
                  color: Colors.red,
                  child: Text("Nope"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(child: Text("Yes"), onPressed: () => exit(0)),
              ],
            ));
  }

  Future<Null> _signOutGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await signIn.signOut();
    await auth.signOut();
    prefs.clear();
    prefs.commit();
    this.setState(() {
      Navigator.of(context).pushNamed("/login");
      loggedIn = false;
    });
    print(loggedIn);
  }
}

class HBodyPage extends StatefulWidget {
  @override
  _HBodyPageState createState() => _HBodyPageState();
}

class _HBodyPageState extends State<HBodyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(child: Row()
          //RaisedButton(
          // child: Text("SignOut"),
          // onPressed: () async {
          //   _signOutGoogle();
          //   Navigator.of(context).pushReplacementNamed('/login');
          // }),
          )
    ]);
  }
}

//Add Bottom Navigation and Floating Action Button
