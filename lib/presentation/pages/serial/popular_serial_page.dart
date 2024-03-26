
import 'package:ditonton/presentation/bloc/serial/popular/serial_popular_bloc.dart';
import 'package:ditonton/presentation/widgets/serial_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class PopularSerialPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  _PopularSerialPageState createState() => _PopularSerialPageState();
}

class _PopularSerialPageState extends State<PopularSerialPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<SerialPopularBloc>().add(OnSerialPopularEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Serial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SerialPopularBloc, SerialPopularState>(
          builder: (_, state) {
            if (state is SerialPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SerialPopularHasData) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemBuilder: (_, index) {
                  final serial = state.result[index];
                  return SerialCard(serial);
                },
                itemCount: state.result.length,
              );
            } else if (state is SerialPopularError) {
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