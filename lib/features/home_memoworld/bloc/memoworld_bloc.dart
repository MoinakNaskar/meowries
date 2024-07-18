import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'memoworld_event.dart';
part 'memoworld_state.dart';

class MemoworldBloc extends Bloc<MemoworldEvent, MemoworldState> {
  MemoworldBloc() : super(MemoworldInitial()) {
    on<MemoworldEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
