import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences prefs;

  StorageService(this.prefs);

  Future<void> saveCredentials(String email, String password) async {
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<void> clearCredentials() async {
    await prefs.remove('email');
    await prefs.remove('password');
  }

  String? getEmail() => prefs.getString('email');
  String? getPassword() => prefs.getString('password');
}

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final storageServiceProvider = Provider<StorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).requireValue;
  return StorageService(prefs);
});
