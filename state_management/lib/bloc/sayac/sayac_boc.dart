import 'dart:async';

import 'package:state_management/bloc/sayac/sayac_event.dart';

class SayacBloc {
  int _sayac = 0;

  // state için Streamcontroller

  final _sayacStateStreamController = StreamController<int>();
  Stream<int> get sayac => _sayacStateStreamController.stream;
  StreamSink<int> get _sayacStateSink => _sayacStateStreamController.sink;

  // eventler için Streamcontroller
  final _sayacEventStreamController = StreamController<SayacEvent>();
  Stream<SayacEvent> get _sayacEventStream =>
      _sayacEventStreamController.stream;
  StreamSink<SayacEvent> get sayacEventSink => _sayacEventStreamController.sink;

  SayacBloc() {
    _sayacEventStream.listen(_mapEventToStaete);
  }

  void _mapEventToStaete(SayacEvent event) {
    if (event is ArttirmaEvent) {
      _sayac++;
    } else {
      _sayac--;
    }
    _sayacStateSink.add(_sayac);
  }
}
