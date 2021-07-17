import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sayac_state.dart';

class SayacCubit extends Cubit<SayacState> {
  SayacCubit() : super(SayacState(0));
  void Arttir() {
    emit(SayacState(state._counter + 1));
  }

  void Azalt() {
    emit(SayacState(state._counter - 1));
  }
}
