import 'package:bloc_ile_counter/bloc_plugin/cubit/sayac_cubit.dart';
import 'package:bloc_ile_counter/counter_bloc/counter_event.dart';
import 'package:bloc_ile_counter/counter_bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc/counter_bloc.dart';
import 'cubit/theme_cubit.dart';
import 'bloc_plugin/cubit/sayac_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, tema) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: tema,
            home: MultiBlocProvider(
              providers: [
                BlocProvider<CounterBloc>(
                  create: (context) => CounterBloc(),
                ),
                BlocProvider<SayacCubit>(
                  create: (context) => SayacCubit(),
                ),
              ],
              child: MyHomePage(),
            ),
          );
        },
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
          }),
          /**
           * Text(
            context.watch<CounterBloc>().state.counter.toString(),
            style: Theme.of(context).textTheme.headline4,
          ),
           */

          BlocBuilder<SayacCubit, SayacState>(builder: (context, sayacState) {
            return Text(
              sayacState.counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            );
          }),
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
          child: Icon(Icons.add_circle),
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          heroTag: "azalt",
          onPressed: () {
            context.read<CounterBloc>().add(CounterAzalt());
          },
          child: Icon(Icons.remove_circle),
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          heroTag: "tema",
          onPressed: () {
            context.read<ThemeCubit>().temaDegistir();
          },
          child: Icon(Icons.brightness_6),
        ),
        SizedBox(height: 15),
        FloatingActionButton(
          heroTag: "arttir",
          onPressed: () {
            context.read<SayacCubit>().Arttir();
          },
          child: Icon(Icons.add),
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          heroTag: "azalt",
          onPressed: () {
            context.read<SayacCubit>().Azalt();
          },
          child: Icon(Icons.remove),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
