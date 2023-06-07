import 'package:flutter/foundation.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required String userId,
    required String displayName,
    required String email,
  }) async {}
}
