import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';

import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/presentation/bloc/serial/playing/serial_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/popular/serial_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/rated/serial_rated_bloc.dart';
import 'package:ditonton/presentation/pages/serial/detail_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/now_playing_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/popular_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/search_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/top_rated_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/watchlist_serial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SerialListPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-list';
  const SerialListPage({Key? key}) : super(key: key);

  @override
  State<SerialListPage> createState() => _SerialListPageState();
}

class _SerialListPageState extends State<SerialListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<SerialNowPlayingBloc>().add(OnSerialNowPlayingEvent());
        context.read<SerialRatedBloc>().add(OnSerialRatedEvent());
        context.read<SerialPopularBloc>().add(OnSerialPopularEvent());
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchSerialPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, WatchlistSerialPage.ROUTE_NAME);
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: 730,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSubHeading(
                  title: 'Now Playing',
                  onTap: () {
                    Navigator.pushNamed(context, NowPlayingSerialPage.ROUTE_NAME);
                  },
                ),
                BlocBuilder<SerialNowPlayingBloc, SerialNowPlayingState>(
                  builder: (context, state) {
                    if (state is SerialNowPlayingLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SerialNowPlayingHasData) {
                      final result = state.result;
                      return SerialList(result);
                    } else if (state is SerialNowPlayingError) {
                      return Expanded(
                        child: Center(
                          child: Text(state.message),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(),
                      );
                    }
                  },
                ),
                _buildSubHeading(
                  title: 'Popular',
                  onTap: () {
                    Navigator.pushNamed(context, PopularSerialPage.ROUTE_NAME);
                  },
                ),
                BlocBuilder<SerialPopularBloc, SerialPopularState>(
                  builder: (context, state) {
                    if (state is SerialPopularLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SerialPopularHasData) {
                      final result = state.result;
                      return SerialList(result);
                    } else if (state is SerialPopularError) {
                      return Expanded(
                        child: Center(
                          child: Text(state.message),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(),
                      );
                    }
                  },
                ),
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () {
                    Navigator.pushNamed(context, TopRatedSerialPage.ROUTE_NAME);
                  },
                ),
                BlocBuilder<SerialRatedBloc, SerialRatedState>(
                  builder: (context, state) {
                    if (state is SerialRatedLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SerialRatedHasData) {
                      final result = state.result;
                      return SerialList(result);
                    } else if (state is SerialRatedError) {
                      return Expanded(
                        child: Center(
                          child: Text(state.message),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Row _buildSubHeading({required String title, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
          ),
        ),
      ),
    ],
  );
}

class SerialList extends StatelessWidget {
  final List<Serial> serial;

  const SerialList(this.serial);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = serial[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailSerialPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: serial.length,
      ),
    );
  }
}
