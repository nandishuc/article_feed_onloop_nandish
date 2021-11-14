import 'package:article_feed_onloop_nandish/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:intl/intl.dart';
import 'package:article_feed_onloop_nandish/utils/string_extensions.dart';
import '../bloc/bookmark/bookmark_bloc.dart';
import '../bloc/bookmark/bookmark_event.dart';
import '../bloc/bookmark/bookmark_state.dart';
import '../bloc/feed/feed_bloc.dart';
import '../bloc/feed/feed_event.dart';
import '../bloc/feed/feed_state.dart';
import '../models/bookmark_model.dart';
import '../models/feed_model.dart';
import '../utils/color_constants.dart';
import '../utils/decoration_utils.dart';
import '../utils/font_family_utils.dart';

/// A widget that displays a list of feeds.
class FeedList extends StatefulWidget {
  const FeedList({Key? key}) : super(key: key);

  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(FeedRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (BuildContext context, FeedState state) {
        if (state is FeedLoaded && state.content != null) {
          return state.content!.isNotEmpty
              ? ListView.builder(
                  itemCount: state.content?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebviewScaffold(
                                    url: state.content![index].contentUrl,
                                    appBar: AppBar(
                                      iconTheme: const IconThemeData(
                                          color: kTextMediumGrey),
                                      backgroundColor: kWhiteColor,
                                      title: Center(
                                        child: Text(
                                          state.content![index].title,
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                            fontFamily: arvo,
                                            fontWeight: FontWeight.bold,
                                            color: kTextMediumGrey,
                                          ),
                                        ),
                                      ),
                                      elevation: 0.5,
                                    ),
                                    withJavascript: true,
                                    withLocalStorage: true,
                                    withZoom: true,
                                  )),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        padding: const EdgeInsets.all(10.0),
                        decoration: containerCardDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    state.content![index].thumbnailUrl,
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/article_icon.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                Center(
                                                  child: Text(
                                                    state.content![index].type
                                                            .toTitleCase +
                                                        ' - ' +
                                                        DateFormat(
                                                                'MMM d, yyyy')
                                                            .format(DateTime
                                                                .parse(state
                                                                    .content![
                                                                        index]
                                                                    .createdAt)),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: arvo,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kTextMediumGrey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            _bookmarkItem(
                                                state.content![index]),
                                          ],
                                        ),
                                        Text(
                                          state.content![index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: const TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: arvo,
                                            fontWeight: FontWeight.bold,
                                            color: kTextDarkGrey,
                                          ),
                                        ),
                                        Text(
                                          state.content![index].description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: arvo,
                                            fontWeight: FontWeight.bold,
                                            color: kTextLightGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4.0),
                              child: const Text(
                                'Shared by OnLoop',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: arvo,
                                  fontWeight: FontWeight.bold,
                                  color: kTextLightGrey,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: boxDecoration(
                                    getFillColor(
                                        state.content![index].tags[0].color),
                                    getBorderColor(
                                        state.content![index].tags[0].color),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    state.content![index].tags[0].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: arvo,
                                      fontWeight: FontWeight.bold,
                                      color: getBorderColor(
                                          state.content![index].tags[0].color),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/thumbs_down.png',
                                      height: 35.0,
                                      width: 35.0,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Image.asset(
                                      'assets/images/thumbs_up.png',
                                      height: 35.0,
                                      width: 35.0,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('No Matches Found.'),
                );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _bookmarkItem(LearnContent content) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            state.bookmarks.any((e) => e.content.title == content.title)
                ? context.read<BookmarkBloc>().add(
                      ToggleBookmarkOff(
                        bookmark: BookmarkModel(
                          content: content,
                          isBookmarked: true,
                        ),
                      ),
                    )
                : context.read<BookmarkBloc>().add(
                      ToggleBookmarkOn(
                        bookmark: BookmarkModel(
                          content: content,
                          isBookmarked: true,
                        ),
                      ),
                    );
          },
          child: state.bookmarks.any((e) => e.content.title == content.title)
              ? Image.asset(
                  'assets/images/save_grey_icon.png',
                  height: 20,
                  width: 20,
                )
              : Image.asset(
                  'assets/images/save_white_icon.png',
                  height: 20,
                  width: 20,
                ),
        );
      },
    );
  }
}
