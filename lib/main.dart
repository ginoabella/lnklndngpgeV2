import 'package:flutter/material.dart';
import 'package:lnk_lndng_pge_v2/links_landing_page/links_landing_page.dart';
import 'package:lnk_lndng_pge_v2/not_found_page.dart';
import 'package:lnk_lndng_pge_v2/settings_page/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
