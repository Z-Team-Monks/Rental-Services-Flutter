part of 'admin_cubit.dart';

@freezed
abstract class AdminState with _$AdminState {
  const factory AdminState.initial(List<Property> properties) = _Initial;
  const factory AdminState.fetchingPosts() = _FetchingPosts;
  const factory AdminState.postFetchSuccess(List<Property> properties) =
      _PostFetchSuccess;
  const factory AdminState.postFetchFailure(String errorMessage) =
      _PostFetchFailure;
  const factory AdminState.rejectApproveOk() = _RejectApproveOk;
  const factory AdminState.rejectApproveError(String errorMessage) =
      _RejectApproveError;
}
