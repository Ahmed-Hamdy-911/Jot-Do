import 'package:flutter_bloc/flutter_bloc.dart';

enum LayoutType { list, grid }

class LayoutCubit extends Cubit<LayoutType> {
  LayoutCubit() : super(LayoutType.list); 

  void toggleLayout(LayoutType type) => emit(type);
}
