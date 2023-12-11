import 'package:equatable/equatable.dart';
import 'package:matchingimageapp/models/photo.dart';

abstract class PhotosEvent extends Equatable {}

class GetPhotosEvent extends PhotosEvent {
  GetPhotosEvent();
  @override
  List<Object> get props => [];
}

class PostPhotosEvent extends PhotosEvent {
  final Photo photo;
  PostPhotosEvent({required this.photo});
  @override
  List<Object> get props => [];
}

class UpdatePhotosEvent extends PhotosEvent {
  final Photo photo;
  UpdatePhotosEvent({required this.photo});
  @override
  List<Object> get props => [];
}

class DeletePhotosEvent extends PhotosEvent {
  final String photoId;
  DeletePhotosEvent({required this.photoId});

  @override
  List<Object> get props => [];
}



