import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_report_event.dart';
part 'task_report_state.dart';

class TaskReportBloc extends Bloc<TaskReportEvent, TaskReportState> {
  TaskReportBloc() : super(TaskReportInitial()) {
    on<TaskReportEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
