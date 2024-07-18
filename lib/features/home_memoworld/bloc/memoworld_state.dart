part of 'memoworld_bloc.dart';

sealed class MemoworldState extends Equatable {
  const MemoworldState();
  
  @override
  List<Object> get props => [];
}

final class MemoworldInitial extends MemoworldState {}
