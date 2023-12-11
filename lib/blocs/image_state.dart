import 'package:matchingimageapp/models/photo.dart';

abstract class PhotoStates {}

class PhotoUninitializedState extends PhotoStates {}

class PhotosFetchingState extends PhotoStates {}

class PhotosFetchedState extends PhotoStates {
  final List<Photo> photos;
  PhotosFetchedState({required this.photos});
}

class PhotosFetchingErrorState extends PhotoStates {
  final String? photo;

  PhotosFetchingErrorState({this.photo});
}

class PhotoDeletingState extends PhotoStates {}

class PhotoDeletedState extends PhotoStates {}

class PhotosDeletingErrorState extends PhotoStates {
  final String? message;

  PhotosDeletingErrorState({this.message});
}

class PhotoPostingState extends PhotoStates {}

class PhotoPostedState extends PhotoStates {}

class PhotoPostingErrorState extends PhotoStates {
  final String? message;

  PhotoPostingErrorState({this.message});
}

class PhotoUpdatingState extends PhotoStates {}

class PhotoUpdatedState extends PhotoStates {}

class PhotoUpdatingErrorState extends PhotoStates {
  final String? message;
  PhotoUpdatingErrorState({this.message});
}

class PhotosEmptyState extends PhotoStates {}


