part of 'instant_photo_bloc.dart';

sealed class InstantPhotoState extends Equatable {
  const InstantPhotoState();
  
  @override
  List<Object> get props => [];
}

final class InstantPhotoInitial extends InstantPhotoState {}
