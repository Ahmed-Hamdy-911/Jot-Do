import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import 'pick_color_state.dart';

class PickColorCubit extends Cubit<PickColorState> {
  PickColorCubit()
      : super(PickColorState(
          selectedColor: const Color(0xff26C281),
        ));
  final List<Color> noteColors = AppColor.noteColors;
  pickColor(Color color) {
    emit(PickColorState(selectedColor: color));
  }
}
