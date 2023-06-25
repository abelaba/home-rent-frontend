part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends ImageEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return "UploadImage";
  }
}

class UsePlaceHolder extends ImageEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() {
    return "UsePlaceHolder";
  }
}