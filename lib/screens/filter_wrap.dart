import 'package:article_feed_onloop_nandish/bloc/filter/filter_events.dart';
import 'package:article_feed_onloop_nandish/utils/color_utils.dart';
import 'package:article_feed_onloop_nandish/utils/decoration_utils.dart';
import 'package:article_feed_onloop_nandish/utils/font_family_utils.dart';

import '../bloc/feed/feed_bloc.dart';
import '../bloc/feed/feed_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/filter/filter_bloc.dart';
import '../bloc/filter/filter_state.dart';

/// A widget which provides a list of filters.
class FilterWrap extends StatefulWidget {
  const FilterWrap({Key? key}) : super(key: key);

  @override
  State<FilterWrap> createState() => _FilterWrapState();
}

class _FilterWrapState extends State<FilterWrap> {
  @override
  void initState() {
    super.initState();
    context.read<FilterBloc>().add(FilterRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (BuildContext context, FilterState state) {
        if (state is FilterLoaded) {
          List<FilterChipData> filterData = List.generate(
            state.filter.tags.length,
            (index) {
              return FilterChipData(
                  name: state.filter.tags[index].name,
                  color: state.filter.tags[index].color);
            },
          );

          return Wrap(
            children: List.generate(
              filterData.length,
              (index) {
                return InkWell(
                  onTap: () {
                    context
                        .read<FeedBloc>()
                        .add(FilterFeed(filterText: filterData[index].name));
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      decoration: boxDecoration(
                        getFillColor(filterData[index].color),
                        getBorderColor(filterData[index].color),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        filterData[index].name,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: arvo,
                          fontWeight: FontWeight.bold,
                          color: getBorderColor(filterData[index].color),
                        ),
                      )),
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class FilterChipData {
  FilterChipData({required this.name, required this.color});

  final String name;
  final String color;
}
