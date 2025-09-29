import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../filters/presentation/views/widgets/custom_filter_bottom_sheet.dart';
import 'bottom_sheet_state.dart';

class BottomSheetCubit extends Cubit<BottomSheetState> {
  BottomSheetCubit() : super(BottomSheetState());
  BuildContext? parentCtx;
  GlobalKey<ScaffoldState>? scaffoldKey ;
  PersistentBottomSheetController? _sheetController;

void setScaffoldKey(GlobalKey<ScaffoldState> key) {
  scaffoldKey = key;
}

  bool get isOpen => state.isOpen;

  /// Open the filter sheet. parentCtx MUST be a BuildContext under the Scaffold.
  void openFilterSheet(BuildContext parentCtx,
      {required String title, required IconData icon}) {
    // if already open, ignore
    if (_sheetController != null) return;

    // show bottom sheet (customFilterBottomSheet should return the controller)
    _sheetController = customFilterBottomSheet(
      parentCtx,
      scaffoldKey: scaffoldKey!,
      title: title,
      icon: icon,
    );

    // emit open
    emit(BottomSheetState(isOpen: true));

    // when sheet closes, clear controller and emit closed state
    _sheetController?.closed.then((_) {
      _sheetController = null;
      emit(BottomSheetState(isOpen: false));
    });
  }

  /// Close programmatically

  void closeSheet() {
    _sheetController?.close();
    _sheetController = null;
    emit(BottomSheetState(isOpen: false));
  }

  @override
  Future<void> close() {
    _sheetController?.close();
    return super.close();
  }
}
