import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:rx_academy/data/models/ReviewAddResponse.dart';
import 'package:rx_academy/data/models/account.dart';
import 'package:rx_academy/data/repository/account_repository.dart';
import 'package:rx_academy/data/repository/review_respository.dart';

import './bloc.dart';

@provide
class ReviewWriteBloc extends Bloc<ReviewWriteEvent, ReviewWriteState> {
  final AccountRepository _accountRepository;
  final ReviewRepository _reviewRepository;
  Account accountObj;

  ReviewWriteBloc(this._accountRepository, this._reviewRepository);

  @override
  ReviewWriteState get initialState => InitialReviewWriteState();

  @override
  Stream<ReviewWriteState> mapEventToState(ReviewWriteEvent event) async* {
    if (event is SaveReviewEvent) {
      yield* _mapEventAddReview(event);
    }

    if (event is FetchEvent) {
      try {
        Account account = await _accountRepository.getUserAccount();
        accountObj = account;
        yield LoadedReviewWriteState(account);
      } catch (error) {
        print('Account resp error');
        print(error);
      }
    }
  }

  @override
  Stream<ReviewWriteState> _mapEventAddReview(event) async* {
    try {
      ReviewAddResponse reviewAddResponse =
          await _reviewRepository.addReview(event.id, event.mark, event.review);

      yield ReviewResponseState(reviewAddResponse, accountObj);
    } catch (error) {
      print(error);
    }
  }
}
