import 'package:rx_academy/data/models/LessonResponse.dart';
import 'package:rx_academy/data/models/QuizResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuizScreenEvent {}

class FetchEvent extends QuizScreenEvent {
  final int courseId;
  final int lessonId;
  final LessonResponse quizResponse;

  FetchEvent(this.courseId, this.lessonId, this.quizResponse);
}
