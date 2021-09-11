import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:rental/core/models/review.dart';
import 'package:rental/features/property/bloc/add_review/add_review_bloc.dart';
import 'package:rental/features/property/bloc/add_review/add_review_event.dart';
import 'package:rental/features/property/bloc/add_review/add_review_state.dart';
import 'package:rental/features/property/bloc/add_review/value_objects/message.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:rental/features/property/repository/add_review/add_review_repository.dart';
import 'package:rental/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_review_bloc_test.mocks.dart';
import 'package:rental/locator.dart' as getIt;

@GenerateMocks([ReviewRepository])
void main() {
  getIt.setUp();
  setupPreferences("token", "tokenknskdnf");
  // getIt.getIt<SharedPreferences>().get

  late AddReviewFormBloc bloc;
  MockReviewRepository mockReviewRepository = MockReviewRepository();

  void setUp() {
    bloc = AddReviewFormBloc(reviewRepository: mockReviewRepository);
  }

  test('initial state should be empty', () {
    setUp();
    expect(bloc.state, equals(AddReviewFormState()));
  });

  group('AddReviewFormBloc', () {
    final review = Review(message: "messsge", rating: 2.0);
    blocTest(
      'emits [AddReviewFormState (valid)] when a valid message is entered',
      build: () {
        setUp();
        return bloc;
      },
      act: (AddReviewFormBloc bloc) =>
          bloc.add(MessageChanged(message: "message")),
      expect: () {
        final message = Message.dirty("message");
        return [
          AddReviewFormState(
            message: message,
            status: Formz.validate([message]),
          )
        ];
      },
    );

    blocTest(
      'emits [AddReviewFormState (invalid)] when invalid message - empty string',
      build: () {
        setUp();
        return bloc;
      },
      act: (AddReviewFormBloc bloc) => bloc.add(MessageChanged(message: "")),
      expect: () {
        final message = Message.dirty("");
        return [
          AddReviewFormState(
            message: message.valid ? message : Message.pure(message.value),
            status: Formz.validate([message]),
          )
        ];
      },
    );

    blocTest(
      'emits [AddReviewFormState (Valid), AddReviewFormState (InProgress), AddReviewFormState (Success)] when is FormSubmitted Succesfully',
      build: () {
        when(
          mockReviewRepository.createRemoteReview(
            review: anyNamed("review"),
            propertyId: anyNamed("propertyId"),
            token: anyNamed("token"),
          ),
        ).thenAnswer((_) => Future.value(review));
        setUp();
        return bloc;
      },
      act: (AddReviewFormBloc bloc) {
        bloc.add(PropertyChanged("propertyId"));
        bloc.add(MessageChanged(message: "message"));
        bloc.add(FormSubmitted());
      },
      expect: () {
        final message = Message.dirty("message");
        return [
          AddReviewFormState(),
          AddReviewFormState(
            message: message,
            status: Formz.validate([message]),
          ),
          AddReviewFormState(
            message: message,
            status: FormzStatus.submissionInProgress,
          ),
          AddReviewFormState(
            message: message,
            status: FormzStatus.submissionSuccess,
          ),
        ];
      },
    );
  });
}

Future setupPreferences(String key, String value) async {
  SharedPreferences.setMockInitialValues(
      <String, Object>{'flutter.' + key: value});
  final preferences = await SharedPreferences.getInstance();
  await preferences.setString(key, value);
}
