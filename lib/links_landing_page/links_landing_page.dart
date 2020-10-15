import 'package:flutter/material.dart';
import 'package:lnk_lndng_pge_v2/links_landing_page/button_link.dart';
import 'package:lnk_lndng_pge_v2/constant.dart';
import 'package:lnk_lndng_pge_v2/links_landing_page/footer.dart';
import 'package:lnk_lndng_pge_v2/model/link_data.dart';
import 'package:provider/provider.dart';

class LinksLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _documents = Provider.of<List<LinkData>>(context);
    if (_documents == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Material(
      child: Column(
        children: [
          SizedBox(height: 35),
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(imageUrl),
            radius: 48,
          ),
          SizedBox(height: 12),
          Text(
            '@gmail',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20),
          if (_documents.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text('No Links yet to Display'),
            ),
          for (var document in _documents)
            ButtonLink(
              title: document.title,
              url: document.url,
            ),
          Spacer(),
          Footer(),
          SizedBox(height: 23),
        ],
      ),
    );
  }
}
