import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:inject/inject.dart';
import 'package:rx_academy/data/cache/cache_manager.dart';
import 'package:rx_academy/data/network/api_provider.dart';
import 'package:rx_academy/data/network/interceptors/interceptor.dart';
import 'package:rx_academy/data/network/interceptors/loggining_interceptor.dart';
import 'package:rx_academy/data/repository/account_repository.dart';
import 'package:rx_academy/data/repository/assignment_repository.dart';
import 'package:rx_academy/data/repository/auth_repository.dart';
import 'package:rx_academy/data/repository/courses_repository.dart';
import 'package:rx_academy/data/repository/home_repository.dart';
import 'package:rx_academy/data/repository/instructors_repository.dart';
import 'package:rx_academy/data/repository/lesson_repository.dart';
import 'package:rx_academy/data/repository/purchase_repository.dart';
import 'package:rx_academy/data/repository/review_respository.dart';
import 'package:rx_academy/data/repository/user_course_repository.dart';
import 'package:rx_academy/data/repository/questions_repository.dart';
import 'package:rx_academy/data/repository/final_repository.dart';
import 'package:rx_academy/ui/bloc/auth/auth_bloc.dart';
import 'package:rx_academy/ui/bloc/quiz_screen/bloc.dart';
import 'package:rx_academy/ui/bloc/splash/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
class AppModule {
  @singleton
  @provide
  AuthRepository userRepository(
          UserApiProvider apiProvider, SharedPreferences sharedPreferences) =>
      new AuthRepositoryImpl(apiProvider, sharedPreferences);

  @singleton
  @provide
  HomeRepository homeRepository(
          UserApiProvider apiProvider, SharedPreferences sharedPreferences) =>
      new HomeRepositoryImpl(apiProvider, sharedPreferences);

  @singleton
  @provide
  CoursesRepository coursesRepository(UserApiProvider apiProvider) =>
      new CoursesRepositoryImpl(apiProvider);

  @singleton
  @provide
  InstructorsRepository instructorsRepository(UserApiProvider apiProvider) =>
      new InstructorsRepositoryImpl(apiProvider);

  @singleton
  @provide
  ReviewRepository reviewRepository(UserApiProvider apiProvider) =>
      new ReviewRepositoryImpl(apiProvider);

  @singleton
  @provide
  AssignmentRepository assignmentRepository(UserApiProvider apiProvider) =>
      new AssignmentRepositoryImpl(apiProvider);

  @singleton
  @provide
  QuestionsRepository questionsRepository(UserApiProvider apiProvider) =>
      new QuestionsRepositoryImpl(apiProvider);

  @singleton
  @provide
  FinalRepository finalRepository(UserApiProvider apiProvider) =>
      new FinalRepositoryImpl(apiProvider);

  @singleton
  @provide
  UserApiProvider provideUserApiProvider(Dio dio) => new UserApiProvider(dio);

  @singleton
  @provide
  Dio provideDio() {
    var dio = Dio();
    dio.interceptors.add(AppInterceptors());
    dio.interceptors.add(LoggingInterceptors());
    dio.transformer = FlutterTransformer();
    return dio;
  }

  @singleton
  @provide
  @asynchronous
  Future<SharedPreferences> provideSharedPreferences() async =>
      await SharedPreferences.getInstance();

  @provide
  AuthBloc provideAuthBloc(AuthRepository repository) =>
      new AuthBloc(repository);

  @provide
  AccountRepository provideAccountRepository(UserApiProvider apiProvider) =>
      new AccountRepositoryImpl(apiProvider);

  @provide
  UserCourseRepository provideUserCourseRepository(
          UserApiProvider apiProvider, CacheManager cacheManager) =>
      new UserCourseRepositoryImpl(apiProvider, cacheManager);

  @provide
  LessonRepository provideLessonRepository(
          UserApiProvider apiProvider, CacheManager manager) =>
      new LessonRepositoryImpl(apiProvider, manager);

  @provide
  SplashBloc provideSplashBloc(AuthRepository repository,
          HomeRepository homeRepository, UserApiProvider apiProvider) =>
      new SplashBloc(repository, homeRepository, apiProvider);

  @provide
  QuizScreenBloc provideQuizScreenBloc(LessonRepository repository) =>
      new QuizScreenBloc(repository);

  @provide
  PurchaseRepository providePurchaseRepository(UserApiProvider apiProvider) =>
      new PurchaseRepositoryImpl(apiProvider);
}
