import 'package:rx_academy/data/models/LessonResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LessonStreamState {}

class InitialLessonStreamState extends LessonStreamState {}

class LoadedLessonStreamState extends LessonStreamState {
  final LessonResponse lessonResponse;

  LoadedLessonStreamState(this.lessonResponse);
}

class CacheWarningLessonStreamState extends LessonStreamState {}
