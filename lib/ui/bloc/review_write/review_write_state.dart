import 'package:rx_academy/data/models/ReviewAddResponse.dart';
import 'package:rx_academy/data/models/account.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReviewWriteState {}

class InitialReviewWriteState extends ReviewWriteState {}

class LoadedReviewWriteState extends ReviewWriteState {
  final Account account;

  LoadedReviewWriteState(this.account);
}

class ReviewResponseState extends ReviewWriteState {
  final ReviewAddResponse reviewAddResponse;
  final Account account;

  ReviewResponseState(this.reviewAddResponse, this.account);
}

class ErrorReviewWriteState extends ReviewWriteState {}
