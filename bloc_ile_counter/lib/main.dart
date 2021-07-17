import 'package:bloc_ile_counter/counter_bloc/counter_event.dart';
import 'package:bloc_ile_counter/counter_bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc/counter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bloc Counter")),
      body: myBody(),
      floatingActionButton: myFabAction(),
    );
  }
}

class myBody extends StatelessWidget {
  const myBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You have pushed the button this many times:'),
          BlocBuilder<CounterBloc, CounterState>(
              builder: (context, counterState) {
            return Text(
              counterState.counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            );
          })
          /**
           * Text(
            context.watch<CounterBloc>().state.counter.toString(),
            style: Theme.of(context).textTheme.headline4,
          ),
           */
        ],
      ),
    );
  }
}

class myFabAction extends StatelessWidget {
  const myFabAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "arttir",
          onPressed: () {
            context.read<CounterBloc>().add(CounterArttir());
          },
          tooltip: 'Increment',
          child: Icon(Icons.add_circle),
        ),
        SizedBox(height: 5),
        FloatingActionButton(
          heroTag: "azalt",
          onPressed: () {
            context.read<CounterBloc>().add(CounterAzalt());
          },
          tooltip: 'Increment',
          child: Icon(Icons.remove_circle),
        ),
      ],
    );
  }
}
