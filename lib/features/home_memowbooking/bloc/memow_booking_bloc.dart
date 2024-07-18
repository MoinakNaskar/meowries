import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'memow_booking_event.dart';
part 'memow_booking_state.dart';

class MemowBookingBloc extends Bloc<MemowBookingEvent, MemowBookingState> {
  MemowBookingBloc() : super(MemowBookingInitial()) {
    on<MemowBookingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
