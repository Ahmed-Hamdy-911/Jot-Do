import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'segment_state.dart';

class SegmentCubit extends Cubit<SegmentState> {
  SegmentCubit() : super(SegmentInitial());
}
