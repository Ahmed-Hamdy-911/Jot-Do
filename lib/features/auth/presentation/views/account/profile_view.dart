import 'package:flutter/material.dart';

import '../../../../../core/services/format_service.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../core/widgets/custom_material_button.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/repository/user_repo_impl.dart';
import '../../../data/models/user_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserRepoImpl _userRepo = UserRepoImpl();
  late final String _userId;

  late TextEditingController _nameController;
  late FocusNode _nameFocusNode;

  Future<UserModel?>? _userFuture;
  String? _originalName;
  bool _isEditing = false;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameFocusNode = FocusNode();
    _userId = _userRepo.currentUserId ?? '';
    _userFuture = _userRepo.getUserById(_userId);

    _nameFocusNode.addListener(() {
      if (_nameFocusNode.hasFocus) {
        setState(() {
          _isEditing = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  Future<void> _refreshUser() async {
    setState(() {
      _userFuture = _userRepo.getUserById(_userId);
    });
  }

  Future<void> _submitName() async {
    final newName = _nameController.text.trim();
    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).error)),
      );
      return;
    }
    if (_originalName != null && newName == _originalName) {
      setState(() => _isEditing = false);
      FocusScope.of(context).unfocus();
      return;
    }

    setState(() => _isUpdating = true);
    try {
      final currentUser = await _userRepo.getUserById(_userId);
      if (currentUser == null) throw Exception("User not found");

      final updatedUser = UserModel(
        id: currentUser.id,
        email: currentUser.email,
        name: newName,
        createdAt: currentUser.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
      );

      await _userRepo.updateUser(updatedUser);
      await _refreshUser();

      _originalName = newName;
      setState(() {
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    } catch (e) {
      debugPrint('Update name error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).error)),
      );
    } finally {
      setState(() => _isUpdating = false);
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
        actions: [
          if (_isEditing)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _isUpdating
                  ? const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : IconButton(
                      onPressed: _submitName,
                      icon: const Icon(Icons.done, color: Colors.green),
                    ),
            ),
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(S.of(context).error));
          }
          final user = snapshot.data;
          if (user == null) {
            return Center(child: Text(S.of(context).error));
          }

          if (_originalName == null) {
            _originalName = user.name;
            _nameController.text = _originalName!;
          }
          final formatCreatedAt = FormatService.formatDateTime(user.createdAt);
          final formatUpdatedAt = user.updatedAt != null
              ? FormatService.formatDateTime(user.updatedAt!)
              : null;

          return Padding(
            padding: const EdgeInsets.all(16.0).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    labelText: S.of(context).name,
                    onTap: () {
                      _nameFocusNode.requestFocus();
                    },
                    onFieldSubmitted: (value) => _submitName(),
                    onChanged: (val) {
                      final changed = val.trim() != (_originalName ?? '');
                      if (changed != _isEditing) {
                        setState(() {
                          _isEditing = changed;
                        });
                      }
                    },
                  ),
                  const MediumSpace(),
                  CustomTextFormField(
                    initialValue: user.email,
                    labelText: S.of(context).email,
                    enabled: false,
                  ),
                  const MediumSpace(),
                  CustomTextFormField(
                    customBorder: const UnderlineInputBorder(),
                    initialValue: formatCreatedAt,
                    labelText: S.of(context).created_at,
                    enabled: false,
                  ),
                  const MediumSpace(),
                  if (user.updatedAt != null)
                    CustomTextFormField(
                      customBorder: const UnderlineInputBorder(),
                      initialValue: formatUpdatedAt,
                      labelText: S.of(context).last_updated,
                      enabled: false,
                    ),
                  const LargeSpace(),
                  CustomMaterialButton(
                    onPressed: () {},
                    text: S.of(context).delete,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
