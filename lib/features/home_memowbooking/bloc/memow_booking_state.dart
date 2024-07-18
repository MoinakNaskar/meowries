part of 'memow_booking_bloc.dart';

sealed class MemowBookingState extends Equatable {
  const MemowBookingState();
  
  @override
  List<Object> get props => [];
}

final class MemowBookingInitial extends MemowBookingState {}
