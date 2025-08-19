import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'pick_color_state.dart';

class PickColorCubit extends Cubit<PickColorState> {
  PickColorCubit()
      : super(PickColorState(
          selectedColor: const Color(0xff26C281),
          selectedIndex: 0,
        ));
  final List<Color> noteColors = const [
    Color(0xff26C281),
    Color(0xff2CC7C9),
    Color(0xff25A4F2),
    Color(0xff5C6BC0),
    Color(0xffA76CE6),
    Color(0xffB2AA8E),
    Color(0xffE07BD2),
    Color(0xffF28EA0),
    Color(0xffDA5A48),
    Color(0xffF89B4C),
    Color(0xffF7DC3A),
    Color(0xffC8E6C9),
    Color(0xff676F54),
    Color(0xffFA9839),
    Color(0xffF9E23B),
    Color(0xff4DD0FC),
    Color(0xff4EF2C0),
    Color(0xffA0F51C),
  ];
  pickColor(int index, Color color) {
    emit(PickColorState(selectedIndex: index, selectedColor: color));
  }
}
