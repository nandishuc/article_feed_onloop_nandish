import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bookmark/bookmark_bloc.dart';
import 'bloc/feed/feed_bloc.dart';
import 'bloc/filter/filter_bloc.dart';
import 'screens/home_screen.dart';
import 'services/learn_feed_api.dart';

Future<void> main() async {
  runApp(const LearnFeedApp());
}

class LearnFeedApp extends StatelessWidget {
  const LearnFeedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FilterBloc(service: LearnFeedApi())),
        BlocProvider(create: (context) => FeedBloc(service: LearnFeedApi())),
        BlocProvider(create: (context) => BookmarkBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OnLoop Learn Feed App by Nandish',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
