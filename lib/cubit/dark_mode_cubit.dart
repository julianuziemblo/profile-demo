import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(DarkModeInitial());

  void toggleTheme() {
    if (state is DarkModeOff) {
      emit(DarkModeOn());
    } else {
      emit(DarkModeOff());
    }
  }
}
