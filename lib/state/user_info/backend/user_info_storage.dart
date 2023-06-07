import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:insta_clon_rivrpo/state/constants/firebase_collection_name.dart';
import 'package:insta_clon_rivrpo/state/constants/firebase_field_name.dart';
import 'package:insta_clon_rivrpo/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required String userId,
    required String displayName,
    required String email,
  }) async {
    //check if user info exists
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        //update
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
        });

        return true;
      } else {
        final payload = UserInfoPayload(
            userId: userId, displayName: displayName, email: email);
        await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.users)
            .add(payload);
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
