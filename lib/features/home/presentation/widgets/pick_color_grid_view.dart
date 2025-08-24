import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../manager/cubits/PickColor/pick_color_cubit.dart';
import '../../../../generated/l10n.dart';
import 'pick_color_item.dart';

class PickColorGridView extends StatelessWidget {
  const PickColorGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth > 600;
    var noteColors = context.read<PickColorCubit>().noteColors;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).selectColorNote,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const MediumSpace(),
          SizedBox(
            height: isWideScreen ? screenWidth * 0.05 : screenWidth * 0.2,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: noteColors.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWideScreen ? 1 : 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return PickColorItem(
                  color: noteColors[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
