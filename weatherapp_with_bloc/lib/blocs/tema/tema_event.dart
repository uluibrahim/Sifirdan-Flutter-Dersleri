import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class TemaEvent extends Equatable {
  TemaEvent([List props = const []]) : super();
}

class TemaDegistirEvent extends TemaEvent {
  String havaDurumuKisaltmasi;
  TemaDegistirEvent({required this.havaDurumuKisaltmasi})
      : super([havaDurumuKisaltmasi]);
  @override
  List<Object?> get props => throw UnimplementedError();
}
