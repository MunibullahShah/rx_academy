import 'package:rx_academy/data/models/LessonResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LessonVideoState {}

class InitialLessonVideoState extends LessonVideoState {}

class LoadedLessonVideoState extends LessonVideoState {
  final LessonResponse lessonResponse;

  LoadedLessonVideoState(this.lessonResponse);
}
