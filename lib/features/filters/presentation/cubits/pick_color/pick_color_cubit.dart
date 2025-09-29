import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors/smart_app_color.dart';
import 'pick_color_state.dart';

class PickColorCubit extends Cubit<PickColorState> {
  final SmartAppColor colors;
  PickColorCubit(this.colors)
      : super(PickColorState(
          selectedColor: colors.filterColors[0],
        ));

  List get listColors => colors.filterColors;

  pickColor(Color color) {
    emit(PickColorState(selectedColor: color));
  }

  reset() {
    state.selectedColor = colors.filterColors[0];
  }
}
