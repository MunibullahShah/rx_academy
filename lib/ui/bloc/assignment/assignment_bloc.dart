import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:rx_academy/data/cache/cache_manager.dart';
import 'package:rx_academy/data/models/AssignmentResponse.dart';
import 'package:rx_academy/data/repository/assignment_repository.dart';

import './bloc.dart';

@provide
class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final AssignmentRepository _assignmentRepository;
  final CacheManager cacheManager;

  AssignmentBloc(this._assignmentRepository, this.cacheManager);

  @override
  AssignmentState get initialState => InitialAssignmentState();

  @override
  Stream<AssignmentState> mapEventToState(AssignmentEvent event) async* {
    if (event is FetchEvent) {
      try {
        AssignmentResponse assignment = await _assignmentRepository
            .getAssignmentInfo(event.courseId, event.assignmentId);

        yield LoadedAssignmentState(assignment);
      } catch (error) {
        if (await cacheManager.isCached(event.courseId)) {
          yield CacheWarningAssignmentState();
        }
        print(error);
      }
    }

    if (event is StartAssignmentEvent) {
      try {
        var assignmentStart = await _assignmentRepository.startAssignment(
            event.courseId, event.assignmentId);
        AssignmentResponse assignment = await _assignmentRepository
            .getAssignmentInfo(event.courseId, event.assignmentId);

        yield LoadedAssignmentState(assignment);
      } catch (error) {
        print(error);
      }
    }

    if (event is AddAssignmentEvent) {
      try {
        int course_id = event.courseId;
        int user_assignment_id = event.userAssignmentId;
        if (event.files != null && event.files.isNotEmpty) {
          event.files.forEach((elem) {
            var uploadFile = _assignmentRepository.uploadAssignmentFile(
                course_id, user_assignment_id, elem);
            print(uploadFile);
          });
        }

        var assignmentAdd = await _assignmentRepository.addAssignment(
            event.courseId, event.userAssignmentId, event.content);

        AssignmentResponse assignment = await _assignmentRepository
            .getAssignmentInfo(event.courseId, event.assignmentId);

        yield LoadedAssignmentState(assignment);
      } catch (error) {
        print(error);
      }
    }
  }
}
