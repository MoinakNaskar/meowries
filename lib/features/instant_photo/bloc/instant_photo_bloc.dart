import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'instant_photo_event.dart';
part 'instant_photo_state.dart';

class InstantPhotoBloc extends Bloc<InstantPhotoEvent, InstantPhotoState> {
  InstantPhotoBloc() : super(InstantPhotoInitial()) {
    on<InstantPhotoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
