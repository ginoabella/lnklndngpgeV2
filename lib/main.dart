import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lnk_lndng_pge_v2/links_landing_page/links_landing_page.dart';
import 'package:lnk_lndng_pge_v2/login/login_page.dart';
import 'package:lnk_lndng_pge_v2/model/link_data.dart';
import 'package:lnk_lndng_pge_v2/not_found_page.dart';
import 'package:lnk_lndng_pge_v2/settings_page/settings_page.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // FirebaseFirestore.instance.settings = Settings(
  //   host: 'localhost:8080',
  //   sslEnabled: false,
  //   persistenceEnabled: false,
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final linksCollection = FirebaseFirestore.instance.collection('links');
    final userLinkDataString = linksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return LinkData.fromDocument(doc);
      }).toList();
    });

    return MultiProvider(
      providers: [
        StreamProvider<User>(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
        ),
        Provider<CollectionReference>(
          create: (context) => linksCollection,
        ),
        StreamProvider<List<LinkData>>(
          create: (context) => userLinkDataString,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Link Landing Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return RouteController(settingsName: settings.name);
            },
          );
        },
        // routes: {
        //   '/': (context) => LinksLandingPage(),
        //   '/settings': (context) => SettingsPage(),
        //   '/login': (context) => LoginPage(),
        // },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) {
            return NotFoundPage();
          });
        },
      ),
    );
  }
}

class RouteController extends StatelessWidget {
  final String settingsName;
  const RouteController({
    Key key,
    @required this.settingsName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userSignedIn = Provider.of<User>(context) != null;
    final notSignedInGoSetting = !userSignedIn && settingsName == '/settings';
    final signedInGoSetting = userSignedIn && settingsName == '/settings';
    if (settingsName == '/') {
      return LinksLandingPage();
    } else if (notSignedInGoSetting || settingsName == '/login') {
      return LoginPage();
    } else if (signedInGoSetting) {
      return SettingsPage();
    } else {
      return NotFoundPage();
    }
  }
}
