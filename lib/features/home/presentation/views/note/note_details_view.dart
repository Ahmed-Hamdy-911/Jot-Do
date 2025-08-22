import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/constant.dart';
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
    final dateTime = widget.noteModel.createdAt;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            floating: false,
            backgroundColor: AppConstants.noteColors[0],
            actions: [
              IconButton(
                onPressed: () {},
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
                        fontSize: screenWidth > 600 ? 30 : 20,
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
                      fontSize: screenWidth > 600 ? 30 : 20,
                    ),
                  ),
                  const SmallSpace(),
                  Text(
                    widget.noteModel.content,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 22 : 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const LargeSpace(),
                  Row(
                    children: [
                      Text(
                        S.of(context).created_at,
                        style: TextStyle(
                          fontSize: screenWidth > 600 ? 18 : 16,
                        ),
                      ),
                      Text(
                        dateTime,
                        style: TextStyle(
                          fontSize: screenWidth > 600 ? 18 : 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
