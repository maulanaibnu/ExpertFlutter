
import 'package:ditonton/presentation/bloc/serial/rated/serial_rated_bloc.dart';

import 'package:ditonton/presentation/widgets/serial_card_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedSerialPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  _TopRatedSerialPageState createState() => _TopRatedSerialPageState();
}

class _TopRatedSerialPageState extends State<TopRatedSerialPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<SerialRatedBloc>().add(OnSerialRatedEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Serial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SerialRatedBloc, SerialRatedState>(
          builder: (_, state) {
            if (state is SerialRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SerialRatedHasData) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemBuilder: (_, index) {
                  final serial = state.result[index];
                  return SerialCard(serial);
                },
                itemCount: state.result.length,
              );
            } else if (state is SerialRatedError) {
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
