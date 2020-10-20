import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lnk_lndng_pge_v2/links_landing_page/links_landing_page.dart';
import 'package:lnk_lndng_pge_v2/model/link_data.dart';
import 'package:lnk_lndng_pge_v2/not_found_page.dart';
import 'package:lnk_lndng_pge_v2/settings_page/settings_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseFirestore.instance.settings = Settings(
    host: 'localhost:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );
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
        Provider<CollectionReference>(
          create: (context) => linksCollection,
        ),
        StreamProvider<List<LinkData>>(
          create: (context) => userLinkDataString,
        ),
      ],
      child: MaterialApp(
        title: 'Link Landing Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LinksLandingPage(),
          '/settings': (context) => SettingsPage(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) {
            return NotFoundPage();
          });
        },
      ),
    );
  }
}
