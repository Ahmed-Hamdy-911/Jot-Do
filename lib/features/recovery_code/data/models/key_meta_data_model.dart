class KeyMetadataModel {
  final bool masterCreated;
  final String? masterCreatorDeviceId;
  final bool recoveryShown;
  final String? recoveryShownByDeviceId;
  final String? masterCreatedAt;
  final String? recoveryShownAt;

  KeyMetadataModel({
    required this.masterCreated,
    this.masterCreatorDeviceId,
    required this.recoveryShown,
    this.recoveryShownByDeviceId,
    this.masterCreatedAt,
    this.recoveryShownAt,
  });

  factory KeyMetadataModel.fromJson(Map<String, dynamic> json) {
    return KeyMetadataModel(
      masterCreated: json['master_created'] ?? false,
      masterCreatorDeviceId: json['master_creator_device_id'],
      recoveryShown: json['recovery_shown'] ?? false,
      recoveryShownByDeviceId: json['recovery_shown_by_device_id'],
      masterCreatedAt: json['master_created_at'],
      recoveryShownAt: json['recovery_shown_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'master_created': masterCreated,
      'master_creator_device_id': masterCreatorDeviceId,
      'recovery_shown': recoveryShown,
      'recovery_shown_by_device_id': recoveryShownByDeviceId,
      'master_created_at': masterCreatedAt,
      'recovery_shown_at': recoveryShownAt,
    };
  }

  // helper method: لسه محتاج يشوف كود الاسترجاع؟
  bool needsRecoveryDisplay(String currentDeviceId) {
    return masterCreated &&
        !recoveryShown &&
        masterCreatorDeviceId == currentDeviceId;
  }

  // copy with: لتحديث جزء من البيانات
  KeyMetadataModel copyWith({
    bool? masterCreated,
    String? masterCreatorDeviceId,
    bool? recoveryShown,
    String? recoveryShownByDeviceId,
    String? masterCreatedAt,
    String? recoveryShownAt,
  }) {
    return KeyMetadataModel(
      masterCreated: masterCreated ?? this.masterCreated,
      masterCreatorDeviceId:
          masterCreatorDeviceId ?? this.masterCreatorDeviceId,
      recoveryShown: recoveryShown ?? this.recoveryShown,
      recoveryShownByDeviceId:
          recoveryShownByDeviceId ?? this.recoveryShownByDeviceId,
      masterCreatedAt: masterCreatedAt ?? this.masterCreatedAt,
      recoveryShownAt: recoveryShownAt ?? this.recoveryShownAt,
    );
  }
}
