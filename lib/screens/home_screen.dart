import 'package:flutter/material.dart';

import '../utils/color_constants.dart';
import '../utils/font_family_utils.dart';
import 'bookmark_screen.dart';
import 'feed_list.dart';
import 'filter_wrap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: const Center(
          child: Text(
            'Learn',
            style: TextStyle(
              fontSize: 22.0,
              fontFamily: arvo,
              fontWeight: FontWeight.bold,
              color: kTextMediumGrey,
            ),
          ),
        ),
        elevation: 0.5,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarkScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/save_white_icon.png',
                height: 20.0,
                width: 20.0,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
              child: const FilterWrap()),
          const Expanded(child: FeedList())
        ],
      ),
    );
  }
}
