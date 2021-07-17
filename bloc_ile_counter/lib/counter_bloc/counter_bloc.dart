import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    // async* ve yield kullanımında metodun sürekli çalıştırılması sağlanır
    if (event is CounterArttir) {
      // state yazarak CounterState classının değişkenlerşne  erişim sağlarız
      yield CounterState(state.counter + 1);
    } else {
      yield CounterState(state.counter - 1);
    }
  }
}
