import 'package:flutter/material.dart';
import 'package:lnk_lndng_pge_v2/links_landing_page/button_link.dart';
import 'package:lnk_lndng_pge_v2/constant.dart';
import 'package:lnk_lndng_pge_v2/links_landing_page/footer.dart';

class LinksLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          for (var document in documents)
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
