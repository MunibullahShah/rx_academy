import 'package:rx_academy/data/models/ReviewResponse.dart';
import 'package:rx_academy/data/models/course/CourseDetailResponse.dart';
import 'package:rx_academy/data/models/purchase/UserPlansResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CourseState {}

class InitialCourseState extends CourseState {}

class OpenPurchaseState extends CourseState {
  final String url;

  OpenPurchaseState(this.url);
}

class LoadedCourseState extends CourseState {
  final CourseDetailResponse courseDetailResponse;
  final ReviewResponse reviewResponse;
  final List<UserPlansBean> userPlans;

  LoadedCourseState(
      this.courseDetailResponse, this.reviewResponse, this.userPlans);
}

class ErrorCourseState extends CourseState {}
