
import 'package:ditonton/presentation/bloc/serial/playing/serial_now_playing_bloc.dart';
import 'package:ditonton/presentation/widgets/serial_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NowPlayingSerialPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv-series';

  @override
  _NowPlayingSerialPageState createState() => _NowPlayingSerialPageState();
}

class _NowPlayingSerialPageState extends State<NowPlayingSerialPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SerialNowPlayingBloc>().add(OnSerialNowPlayingEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Serial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SerialNowPlayingBloc, SerialNowPlayingState>(
          builder: (_, state) {
            if (state is SerialNowPlayingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SerialNowPlayingHasData) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemBuilder: (_, index) {
                  final serial = state.result[index];
                  return SerialCard(serial);
                },
                itemCount: state.result.length,
              );
            } else if (state is SerialNowPlayingError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Empty data'),
              );
            }
          },
        ),
      ),
    );
  }
}