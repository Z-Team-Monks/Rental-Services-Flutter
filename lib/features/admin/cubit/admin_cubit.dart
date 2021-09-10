import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/admin/repository/admin_repository.dart';

part 'admin_state.dart';
part 'admin_cubit.freezed.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository repository;
  AdminCubit({required this.repository}) : super(AdminState.initial([]));

  void fetchPosts() async {
    final results = await repository.fetchProperties();
    emit(results.fold(
        (l) => l.maybeMap(
            serverError: (serverError) =>
                AdminState.postFetchFailure("Server Error! please try again."),
            networkError: (networkError) =>
                AdminState.postFetchFailure("Please check your connection!"),
            unAuthorized: (unAuthorized) => AdminState.postFetchFailure(
                "Unauthorized! please login as admin"),
                invalidValue: (invalid)=> AdminState.postFetchFailure("Invalid token!"),
            orElse: () =>
                AdminState.postFetchFailure("Something went very wrong!")),
        (r) => AdminState.postFetchSuccess(r)));
  }

  void approvePost(String? id) async {
    if (id == null) return;
    print("before");
    final results = await repository.approveProperty(id);
    print("after");
    emit(results.fold(
        (l) => l.maybeMap(
            serverError: (serverError) => AdminState.rejectApproveError(
                "Server Error! please try again."),
            networkError: (networkError) =>
                AdminState.rejectApproveError("Please check your connection!"),
            unAuthorized: (unAuthorized) => AdminState.rejectApproveError(
                "Unauthorized! please login as admin"),
            orElse: () =>
                AdminState.rejectApproveError("Something went very wrong!")),
        (r) => AdminState.rejectApproveOk()));
  }

  void disapprovePost(String? id) async {
    if (id == null) return;
    final results = await repository.disApproveProperty(id);
    emit(results.fold(
        (l) => l.maybeMap(
            serverError: (serverError) => AdminState.rejectApproveError(
                "Server Error! please try again."),
            networkError: (networkError) =>
                AdminState.rejectApproveError("Please check your connection!"),
            unAuthorized: (unAuthorized) => AdminState.rejectApproveError(
                "Unauthorized! please login as admin"),
            orElse: () =>
                AdminState.rejectApproveError("Something went very wrong!")),
        (r) => AdminState.rejectApproveOk()));
  }
}
