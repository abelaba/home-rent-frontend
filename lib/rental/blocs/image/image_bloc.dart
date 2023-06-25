import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial());

  @override
  Stream<ImageState> mapEventToState(
    ImageEvent event,
  ) async* {
    if (event is UploadImage) {
      yield ImageLoading();
      try {
        yield ImageUploaded();
      } catch (e) {
        yield ImageUploadFailed();
      }
    }
    if (event is UsePlaceHolder) {
      yield ImageInitial();
    }
  }
}