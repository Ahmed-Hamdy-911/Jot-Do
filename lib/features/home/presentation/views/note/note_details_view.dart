import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/services/format_service.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/note_model.dart';
import 'widgets/note_sync_warning.dart';

class NoteDetailsView extends StatefulWidget {
  final NoteModel noteModel;
  const NoteDetailsView({super.key, required this.noteModel});

  @override
  State<NoteDetailsView> createState() => _NoteDetailsViewState();
}

class _NoteDetailsViewState extends State<NoteDetailsView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (140 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final createdAt = widget.noteModel.createdAt;
    final lastUpdated = widget.noteModel.lastUpdatedAt;
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;

    var titleColor = darkMode ? AppColor.white70 : AppColor.blackColor;
    var contentColor = darkMode ? AppColor.grey300 : AppColor.grey600;
    var dateColor = darkMode ? AppColor.grey300 : AppColor.grey600;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            floating: false,
            backgroundColor: Color(widget.noteModel.color),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.updateNote,
                    arguments: widget.noteModel,
                  );
                },
                icon: const Icon(IconlyBold.edit),
              ),
            ],
            title:
                _isSliverAppBarExpanded ? Text(widget.noteModel.title) : null,
            flexibleSpace: FlexibleSpaceBar(
              title: !_isSliverAppBarExpanded
                  ? Text(
                      S.of(context).note_details,
                      style: TextStyle(fontSize: screenWidth > 600 ? 22 : 18),
                    )
                  : null,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  widget.noteModel.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth > 600 ? 22 : 18,
                    color: titleColor,
                  ),
                ),
                customDivider(),
                if (widget.noteModel.content.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SmallSpace(),
                      Text(
                        widget.noteModel.content,
                        style: TextStyle(
                          fontSize: screenWidth > 600 ? 18 : 15,
                          color: contentColor,
                        ),
                      ),
                      customDivider(),
                    ],
                  ),
                if (widget.noteModel.lastUpdatedAt != null)
                  customShowTime(
                    context,
                    S.of(context).last_updated,
                    lastUpdated!,
                    dateColor: dateColor,
                  ),
                customShowTime(
                  context,
                  S.of(context).created_at,
                  createdAt,
                  dateColor: dateColor,
                ),
                if (!(widget.noteModel.isSynced ?? true))
                  const NoteSyncWarning(),
                if (widget.noteModel.content.isEmpty ||
                    widget.noteModel.content.length < 500)
                  SizedBox(
                    height: screenWidth > 600
                        ? screenWidth * 0.28
                        : screenHeight * 0.48,
                  ),
                if (widget.noteModel.content.isEmpty ||
                    widget.noteModel.content.length < 1500)
                  SizedBox(
                    height: screenWidth > 600
                        ? screenWidth * 0.02
                        : screenHeight * 0.24,
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget customShowTime(
    context,
    String text,
    String dateTime, {
    Color? dateColor,
  }) {
    var screenWidth = MediaQuery.of(context).size.width;
    final formattedDateTime = FormatService.formatDateTime(dateTime);
    return Text(
      textAlign: TextAlign.start,
      text + formattedDateTime,
      style: TextStyle(fontSize: screenWidth > 600 ? 16 : 14, color: dateColor),
    );
  }
}
