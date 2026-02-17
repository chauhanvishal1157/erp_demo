import 'package:equatable/equatable.dart';

abstract class DeleteVendorLevelState extends Equatable {
  @override
  List<Object> get props => [];
}


/// delete vendor level
class InitialDeleteVendorLevelState extends DeleteVendorLevelState {}

class LoadingDeleteVendorLevelState extends DeleteVendorLevelState {}

class LoadedDeleteVendorLevelState extends DeleteVendorLevelState {
  final String message;

  LoadedDeleteVendorLevelState({
    required this.message,
  });
}

class FailureDeleteVendorLevelState extends DeleteVendorLevelState {
  final String error;

  FailureDeleteVendorLevelState({
    required this.error,
  });
}


