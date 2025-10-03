import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/custom/custom_card.dart';
import '../../../../../core/widgets/custom/custom_loading.dart';
import '../../../../../core/models/message_type.dart';
import '../../../../../core/widgets/buttons/custom_material_button.dart';
import '../../../../../core/widgets/custom/custom_show_time_to_page.dart';
import '../../../../../core/widgets/components/custom_snackbar.dart';
import '../../../../../core/widgets/custom_fields/custom_text_form.dart';
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
    if (AppConstants.appService.isOnline == false) {
      CustomSnackBar.showSnackBar(
        S.of(context).noInternet,
        context,
        MessageType.error,
      );
      return;
    } else {
      final newName = _nameController.text.trim();
      if (newName.isEmpty) {
        CustomSnackBar.showSnackBar(
          S.of(context).error,
          context,
          MessageType.error,
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
          updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        await _userRepo.updateUser(updatedUser);
        await _refreshUser();

        _originalName = newName;
        setState(() {
          _isEditing = false;
        });

        CustomSnackBar.showSnackBar(
          S.of(context).profile_updated_success,
          context,
          MessageType.success,
        );
      } catch (e) {
        debugPrint('Update name error: $e');
        CustomSnackBar.showSnackBar(
          S.of(context).profile_updated_failed,
          context,
          MessageType.error,
        );
      } finally {
        setState(() => _isUpdating = false);
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var colors = SmartAppColor(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).profile,
        ),
        actions: [
          if (_isEditing)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 16.0),
              child: _isUpdating
                  ? Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: colors.green,
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: _submitName,
                      icon: Icon(Icons.done, color: colors.green),
                    ),
            ),
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomLoading(
                child: const SizedBox.expand(),
                state: snapshot.connectionState == ConnectionState.waiting);
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

          return Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0).copyWith(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                width: screenWidth >= 600 ? 600 : screenWidth,
                constraints: BoxConstraints(maxHeight: screenHeight - 100),
                child: CustomCard(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        labelText: S.of(context).name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).error_required_field;
                          } else if (value.length < 3) {
                            return S.of(context).error_short_name;
                          } else if (value.startsWith(RegExp(r'^[0-9]'))) {
                            return S.of(context).error_name_starts_with_number;
                          } else if (value.contains(RegExp(r'^.*[@/$!%*?&]'))) {
                            return S
                                .of(context)
                                .error_name_contains_special_characters;
                          }
                          return null;
                        },
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
                      AppComponents.mediumVerticalSpace(),
                      CustomTextFormField(
                        initialValue: user.email,
                        labelText: S.of(context).email,
                        enabled: false,
                      ),
                      CustomShowTimeToPage(
                        isUpdating: user.updatedAt,
                        createdAt: user.createdAt,
                        updatedAt: user.updatedAt,
                      ),
                      AppComponents.largeVerticalSpace(),
                      CustomMaterialButton(
                        onPressed: () {
                          CustomSnackBar.showSnackBar(
                            S.of(context).comingSoon,
                            context,
                            MessageType.info,
                          );
                        },
                        text: S.of(context).delete,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
