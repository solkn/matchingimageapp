import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:matchingimageapp/blocs/image_event.dart';
import 'package:matchingimageapp/blocs/image_state.dart';
import 'package:matchingimageapp/models/photo.dart';
import 'package:matchingimageapp/repository/photo_repository.dart';

class PhotosBloc extends Bloc<PhotosEvent,PhotoStates> {
  final PhotoRepository resultRepository;
  PhotosBloc({required this.resultRepository})
      : super(PhotoUninitializedState());

  @override
  Stream<PhotoStates> mapEventToState(PhotosEvent event) async* {
    if (event is GetPhotosEvent) {
      yield* _mapGetResultsEventToState();
    } else if (event is PostPhotosEvent) {
      yield* _mapPostResultEventToState(event.photo);
    } else if (event is UpdatePhotosEvent) {
      yield* _mapUpdateResultEventToState(event.photo);
    } else if (event is DeletePhotosEvent) {
      yield* _mapDeleteResultEventToState(event.photoId);
    }
  }

  Stream<PhotoStates> _mapGetResultsEventToState() async* {

    yield PhotosFetchingState();
    try {
      List<Photo> results = await resultRepository.getPhotos();
      if (results.length == 0) {
        yield PhotosEmptyState();
      } else {
        yield PhotosFetchedState(photos: results);
      }
    } on HttpException catch (e) {
      yield PhotosFetchingErrorState();
    } catch (e) {
      yield PhotosFetchingErrorState();
    }
  }

  Stream<PhotoStates> _mapPostResultEventToState(Photo result) async* {
    yield PhotoPostingState();
    try {
      await resultRepository.postPhoto(result);
      yield PhotoPostedState();
    } on HttpException catch (e) {
      yield PhotoPostingErrorState(message: e.message);
    } catch (e) {
      yield PhotoPostingErrorState();
    }
  }

  Stream<PhotoStates> _mapUpdateResultEventToState(Photo result) async* {
    yield PhotoDeletingState();
    try {
      await resultRepository.putPhoto(result);
      yield PhotoUpdatedState();
    } on HttpException catch (e) {
      yield PhotoUpdatingErrorState(message: e.message);
    } catch (e) {
      yield PhotoUpdatingErrorState();
    }
  }

  Stream<PhotoStates> _mapDeleteResultEventToState(String resultId) async* {
    yield PhotoDeletingState();
    try {
      await resultRepository.deletePhoto(resultId);
      yield PhotoDeletedState();
    } on HttpException catch (e) {
      yield PhotosDeletingErrorState(message: e.message);
    } catch (e) {
      yield PhotoDeletingState();
    }
  }
}




