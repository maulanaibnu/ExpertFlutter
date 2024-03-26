
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/serial/watchlist/serial_watchlist_bloc.dart';

import 'package:ditonton/presentation/widgets/serial_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class WatchlistSerialPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-serial';

  @override
  _WatchlistSerialPageState createState() => _WatchlistSerialPageState();
}

class _WatchlistSerialPageState extends State<WatchlistSerialPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<SerialWatchlistBloc>().add(OnGethWatchlistSerial()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<SerialWatchlistBloc>().add(OnGethWatchlistSerial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
      child: BlocBuilder<SerialWatchlistBloc, WatchlistSerialState>(
          builder: (context, state) {
            if (state is WatchlistSerialLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistSerialHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serial = state.result[index];
                  return SerialCard(serial);
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistSerialEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.visibility_off, size: 72),
                    const SizedBox(height: 2),
                    Text('Empty Watchlist'),
                  ],
                ),
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('error'),
              );
            }
          },
        ),
    ),
  );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}