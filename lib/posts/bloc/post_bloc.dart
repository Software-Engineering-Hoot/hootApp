import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/service/advert.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 20;
const startIndex = 0;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;
  final AdvertService advertService = AdvertService();

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      late final List<AdvertModel> posts;
      if (event.petType.isNotEmpty ||
          event.city.isNotEmpty ||
          event.amount != 0) {
        posts =
            await _fetchPostsByFilter(event.city, event.petType, event.amount);
      } else {
        posts = await _fetchPosts();
      }
      if (state.status == PostStatus.initial) {
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<AdvertModel>> _fetchPosts([int startIndex = 0]) async {
    var advertList = await advertService.getAdvert();
    print(advertList);
    return advertList;
  }

  Future<List<AdvertModel>> _fetchPostsByFilter(
      String city, String petType, double amount) async {
    var resp = await advertService.filterByAll(city, petType, amount);
    return resp;
  }
}
