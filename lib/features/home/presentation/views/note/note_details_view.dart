import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/note_model.dart';

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
              )
            ],
            title:
                _isSliverAppBarExpanded ? Text(widget.noteModel.title) : null,
            flexibleSpace: FlexibleSpaceBar(
              title: !_isSliverAppBarExpanded
                  ? Text(
                      S.of(context).note_details,
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 22 : 18,
                      ),
                    )
                  : null,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    widget.noteModel.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth > 600 ? 22 : 18,
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
                            color: Colors.grey[600],
                          ),
                        ),
                        customDivider(),
                      ],
                    ),
                  if (widget.noteModel.lastUpdatedAt != null)
                    customShowTime(
                        context, S.of(context).last_updated, lastUpdated!),
                  customShowTime(context, S.of(context).created_at, createdAt),
                  if (widget.noteModel.content.isEmpty ||
                      widget.noteModel.content.length < 500)
                    SizedBox(
                      height: screenWidth > 600
                          ? screenWidth * 0.31
                          : screenHeight * 0.51,
                    ),
                  if (widget.noteModel.content.isEmpty ||
                      widget.noteModel.content.length < 1500)
                    SizedBox(
                      height: screenWidth > 600
                          ? screenWidth * 0.06
                          : screenHeight * 0.26,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customDivider() => const Divider(
        height: 30,
      );

  Widget customShowTime(context, String text, String dateTime) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Text(
      textAlign: TextAlign.start,
      text+ dateTime,
      style: TextStyle(
        fontSize: screenWidth > 600 ? 16 : 14,
      ),
    );
  }
}
