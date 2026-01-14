part of 'dark_mode_cubit.dart';

@immutable
sealed class DarkModeState {}

final class DarkModeInitial extends DarkModeState {}

final class DarkModeOn extends DarkModeState {}

final class DarkModeOff extends DarkModeState {}
