import 'package:article_feed_onloop_nandish/bloc/filter/filter_events.dart';
import 'package:article_feed_onloop_nandish/bloc/filter/filter_state.dart';
import 'package:article_feed_onloop_nandish/services/learn_feed_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Defines the filter bloc.
class FilterBloc extends Bloc<FilterEvents, FilterState> {
  FilterBloc({required this.service}) : super(FilterInitialState()) {
    on(_onFilterRequested);
  }

  /// The filter api service.
  final LearnFeedApi service;

  Future<void> _onFilterRequested(event, emit) async {
    try {
      emit(FilterLoading());
      final filter = await service.fetchFilters();
      emit(FilterLoaded(filter));
    } catch (error) {
      emit(FilterError());
    }
  }
}
