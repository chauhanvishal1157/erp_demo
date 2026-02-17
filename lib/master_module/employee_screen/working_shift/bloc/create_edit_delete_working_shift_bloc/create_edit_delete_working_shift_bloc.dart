import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_edit_delete_working_shift_event.dart';
part 'create_edit_delete_working_shift_state.dart';

class CreateEditDeleteWorkingShiftBloc extends Bloc<CreateEditDeleteWorkingShiftEvent, CreateEditDeleteWorkingShiftState> {
  CreateEditDeleteWorkingShiftBloc() : super(CreateEditDeleteWorkingShiftInitial()) {
    on<CreateEditDeleteWorkingShiftEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
