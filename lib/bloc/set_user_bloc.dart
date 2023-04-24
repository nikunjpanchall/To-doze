import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'set_user_event.dart';
part 'set_user_state.dart';

class SetUserBloc extends Bloc<SetUserEvent, SetUserState> {
  SetUserBloc() : super(SetUserInitial()) {
    on<SetUser>((event, emit) {
      try {
        emit(SetUserInitial());
      } catch (e) {}
    });
  }
}
