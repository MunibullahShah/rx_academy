import 'package:rx_academy/data/cache/cache_manager.dart';
import 'package:rx_academy/data/models/course/CourseDetailResponse.dart';
import 'package:rx_academy/data/models/curriculum.dart';
import 'package:rx_academy/data/models/user_course.dart';
import 'package:rx_academy/data/network/api_provider.dart';

abstract class UserCourseRepository {
  Future<UserCourseResponse> getUserCourses();

  Future<CurriculumResponse> getCourseCurriculum(int id);

  Future<CourseDetailResponse> getCourse(int courseId);
}

class UserCourseRepositoryImpl extends UserCourseRepository {
  final UserApiProvider _apiProvider;
  final CacheManager cacheManager;

  UserCourseRepositoryImpl(this._apiProvider, this.cacheManager);

  @override
  Future<UserCourseResponse> getUserCourses() {
    return _apiProvider.getUserCourses();
  }

  @override
  Future<CurriculumResponse> getCourseCurriculum(int id) {
    return _apiProvider.getCourseCurriculum(id);
  }

  @override
  Future<CourseDetailResponse> getCourse(int courseId) {
    return _apiProvider.getCourse(courseId);
  }
}
