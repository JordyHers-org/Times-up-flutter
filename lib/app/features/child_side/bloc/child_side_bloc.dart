import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'child_side_event.dart';
part 'child_side_state.dart';

class ChildSideBloc extends Bloc<ChildSideEvent, ChildSideState> {
  ChildSideBloc() : super(ChildSideInitial()) {
    on<GetNotifications>((event, emit) => emit(ChildSideNotification()));
    on<GetAppList>((event, emit) => emit(ChildSideAppList()));
  }
}
