import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/service/advert.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'advert_event.dart';
part 'advert_state.dart';

const _postLimit = 20;
const startIndex = 0;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class AdvertBloc extends Bloc<AdvertEvent, AdvertState> {
  AdvertBloc({required this.httpClient}) : super(const AdvertState()) {
    on<AdvertFetched>(
      _onAdvertFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;
  final AdvertService advertService = AdvertService();

  Future<void> _onAdvertFetched(
    AdvertFetched event,
    Emitter<AdvertState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      late final List<AdvertModel> posts;
      if (event.petType.isNotEmpty ||
          event.city.isNotEmpty ||
          event.amount != 0) {
        posts = await _fetchAdvertsByFilter(
            event.city, event.petType, event.amount);
      } else {
        posts = await _fetchAdverts();
      }
      if (state.status == AdvertStatus.initial) {
        return emit(
          state.copyWith(
            status: AdvertStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: AdvertStatus.success,
                posts: List.of(state.adverts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: AdvertStatus.failure));
    }
  }

  Future<List<AdvertModel>> _fetchAdverts([int startIndex = 0]) async {
    var advertList = await advertService.getAdvert();
    print(advertList);
    return advertList;
  }

  Future<List<AdvertModel>> _fetchAdvertsByFilter(
      String city, String petType, double amount) async {
    var resp = await advertService.filterByAll(city, petType, amount);
    return resp;
  }
}
