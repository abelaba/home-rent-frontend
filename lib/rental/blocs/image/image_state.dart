part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageLoading extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageUploaded extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageUploadFailed extends ImageState {
  @override
  List<Object> get props => [];
}