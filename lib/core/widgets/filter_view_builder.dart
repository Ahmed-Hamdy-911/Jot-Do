// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../constants/app_colors.dart';
// import '../cubits/filter/filter_cubit.dart';
// import '../../features/settings/presentation/cubits/setting_cubit.dart';

// class FilterViewBuilder extends StatelessWidget {
//   const FilterViewBuilder({
//     super.key,
//     required this.filterList,
//   });
//   final List<dynamic> filterList;

//   @override
//   Widget build(BuildContext context) {
//     return FilterListView(filterList: filterList);
//   }
// }

// class FilterListView extends StatelessWidget {
//   const FilterListView({
//     super.key,
//     required this.filterList,
//   });

//   final List filterList;

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     return SizedBox(
//       height: screenWidth > 600 ? 40 : 40,
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(vertical: 8).copyWith(bottom: 4),
//         scrollDirection: Axis.horizontal,
//         itemCount: filterList.length,
//         itemBuilder: (context, index) => FilterItem(
//           filerIndex: index,
//           title: filterList[index],
//         ),
//         separatorBuilder: (context, index) => const SizedBox(width: 10),
//       ),
//     );
//   }
// }

// class FilterItem extends StatelessWidget {
//   const FilterItem({
//     super.key,
//     required this.title,
//     required this.filerIndex,
//   });
//   final String title;
//   final int filerIndex;

//   @override
//   Widget build(BuildContext context) {
//     var screenW = MediaQuery.of(context).size.width;
//     var segmentCubit = context.read<FilterCubit>();
//     bool isSelected =
//         context.watch<FilterCubit>().state.selectedIndex == filerIndex;
//     var darkMode =
//         context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
//     var selectedBGColor = darkMode ? AppColor.grey600 : AppColor.whiteColor;
//     var selectedTextColor = darkMode ? AppColor.white70 : AppColor.blackColor;
//     return OutlinedButton(
//         onPressed: () {
//           segmentCubit.switchSelection(filerIndex);
//         },
//         style: ButtonStyle(
//             shadowColor: null,
//             padding: WidgetStatePropertyAll(EdgeInsetsDirectional.symmetric(
//               horizontal: screenW > 600 ? 60 : 30,
//             )),
//             shape: WidgetStatePropertyAll(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             side: WidgetStatePropertyAll(
//               BorderSide(
//                 color: isSelected ? Colors.transparent : Colors.grey[800]!,
//               ),
//             ),
//             backgroundColor: WidgetStatePropertyAll(
//                 isSelected ? AppColor.mainLightColor : selectedBGColor)),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? AppColor.whiteColor : selectedTextColor,
//             fontSize: screenW > 600 ? 17 : 14,
//           ),
//         ));
//   }
// }
