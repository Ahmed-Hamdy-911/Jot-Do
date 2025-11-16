class UploadWrappedMasterKey {
  final String uid;
  final String method; // 'device' | 'recovery'
  final String deviceId;
  final String deviceName;
  final String wrappedMaster;
  final String nonce;
  final String mac;
  String? salt;
  String? creationDate;

  UploadWrappedMasterKey({
    required this.uid,
    required this.method,
    required this.deviceId,
    required this.deviceName,
    required this.wrappedMaster,
    required this.nonce,
    required this.mac,
    this.salt,
    this.creationDate,
  });

  // Defensive fromJson (handles missing fields)
  factory UploadWrappedMasterKey.fromJson(Map<String, dynamic> json) {
    return UploadWrappedMasterKey(
      uid: json['uid'] ?? '',
      method: json['method'] ?? '',
      deviceId: json['device_id'] ?? '',
      deviceName: json['device_name'] ?? '',
      wrappedMaster: json['wrapped_master'] ?? '',
      nonce: json['nonce'] ?? '',
      mac: json['mac'] ?? '',
      salt: json['salt'],
      creationDate: json['creation_date'] ?? json['created_at'] ?? null,
    );
  }

  // Proper toJson method (returns Map)
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'uid': uid,
      'method': method,
      'device_id': deviceId,
      'device_name': deviceName,
      'wrapped_master': wrappedMaster,
      'nonce': nonce,
      'mac': mac,
    };
    if (salt != null) map['salt'] = salt;
    if (creationDate != null) map['creation_date'] = creationDate;
    return map;
  }

  // copy
  factory UploadWrappedMasterKey.copyWith(UploadWrappedMasterKey other) {
    return UploadWrappedMasterKey(
      uid: other.uid,
      method: other.method,
      deviceId: other.deviceId,
      deviceName: other.deviceName,
      wrappedMaster: other.wrappedMaster,
      nonce: other.nonce,
      mac: other.mac,
      salt: other.salt,
      creationDate: other.creationDate,
    );
  }

  // empty
  factory UploadWrappedMasterKey.empty() {
    return UploadWrappedMasterKey(
      uid: '',
      method: '',
      deviceId: '',
      deviceName: '',
      wrappedMaster: '',
      nonce: '',
      mac: '',
      salt: null,
      creationDate: null,
    );
  }

  bool get isDeviceKey => method == 'device';
  bool get isRecoveryKey => method == 'recovery';
}
