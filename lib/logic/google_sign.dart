import 'package:google_sign_in/google_sign_in.dart';
import 'package:make_tycoon/game_manager.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'], // 필요한 권한 설정
  clientId: '591855019278-0o9c291tthe7mdthfg2sed5mtl9cscab.apps.googleusercontent.com',
);

Future<String?> signInWithGoogle() async {
  try {
    // Google 계정 선택
    final GoogleSignInAccount? account = await _googleSignIn.signIn();

    // 인증 정보 가져오기
    final GoogleSignInAuthentication auth = await account!.authentication;

    // ID Token 반환 (서버에 전달)
    print('Google Sign-In success!! ${auth.idToken}');
    GameManager().token = auth.idToken!;
    return auth.idToken;
  } catch (e) {
    print('Google Sign-In failed: $e');
    return null;
  }
}
