import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoot/posts/bloc/advert_bloc.dart';
import 'package:hoot/posts/view/advert_list.dart';
import 'package:http/http.dart' as http;

class AdvertsPage extends StatelessWidget {
  const AdvertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => AdvertBloc(httpClient: http.Client())
          ..add(AdvertFetched("", "", 0)),
        child: const AdvertsList(),
      ),
    );
  }
}
