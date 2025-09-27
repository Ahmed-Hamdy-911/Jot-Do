import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../constants/colors/smart_app_color.dart';
import 'pick_color_state.dart';

class PickColorCubit extends Cubit<PickColorState> {
  final SmartAppColor colors;
  PickColorCubit(this.colors)
      : super(PickColorState(
          selectedColor: const Color(0xff26C281),
        ));
  List get noteColors => colors.filterColors;
  pickColor(Color color) {
    emit(PickColorState(selectedColor: color));
  }
}
