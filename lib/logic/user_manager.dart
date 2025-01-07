import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserManager {
  static const String _guestIdKey = 'guest_id';

  // 익명 ID 가져오기 (없으면 생성)
  static Future<String> getOrCreateGuestId() async {
    final prefs = await SharedPreferences.getInstance();

    // 기존 guest_id가 있으면 반환
    if (prefs.containsKey(_guestIdKey)) {
      return prefs.getString(_guestIdKey)!;
    }

    // 새로운 guest_id 생성 및 저장
    final Uuid uuid = Uuid();
    final String newGuestId = uuid.v4(); // 랜덤 고유 ID 생성
    await prefs.setString(_guestIdKey, newGuestId);

    return newGuestId;
  }
}
