import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/cubit/dark_mode_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DarkModeCubit>().state;
    return Scaffold(
      backgroundColor: state is DarkModeOn ? Colors.black : Colors.white,
      body: Center(
        child: Switch.adaptive(
          value: state is DarkModeOff,
          onChanged: (newValue) {
            context.read<DarkModeCubit>().toggleTheme();
          },
        ),
      ),
    );
  }
}
