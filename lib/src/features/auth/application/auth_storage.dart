import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travee/services/secure_storage.dart';
import 'package:travee/src/utils/constants.dart';

final authStorageProvider = Provider<AuthStorage>((ref) => AuthStorage(ref));

class AuthStorage {
  final Ref ref;

  AuthStorage(this.ref);

  Future<void> deleteAllSaved() async {
    await ref.watch(secureStorageProvider).deleteAll();
  }

  Future<String?> getToken() async {
    return await ref.watch(secureStorageProvider).read(key: StorageKeys.token);
  }

  Future<void> saveToken({required String token}) async {
    return await ref
        .watch(secureStorageProvider)
        .write(key: StorageKeys.token, value: token);
  }

  Future<String?> getUserId() async {
    return await ref.watch(secureStorageProvider).read(key: StorageKeys.userId);
  }

  Future<void> saveUserId({required String userId}) async {
    return await ref
        .watch(secureStorageProvider)
        .write(key: StorageKeys.userId, value: userId);
  }

  Future<String?> getEmailId() async {
    return await ref
        .watch(secureStorageProvider)
        .read(key: StorageKeys.emailId);
  }

  Future<void> saveEmailId({required String emailId}) async {
    return await ref
        .watch(secureStorageProvider)
        .write(key: StorageKeys.emailId, value: emailId);
  }

  Future<String?> getEmail() async {
    return await ref
        .watch(secureStorageProvider)
        .read(key: StorageKeys.email);
  }

  Future<void> saveEmail({required String email}) async {
    return await ref
        .watch(secureStorageProvider)
        .write(key: StorageKeys.emailId, value: email);
  }

  Future<String?> getId() async {
    return await ref
        .watch(secureStorageProvider)
        .read(key: StorageKeys.id);
  }

  Future<void> saveId({required String id}) async {
    return await ref
        .watch(secureStorageProvider)
        .write(key: StorageKeys.id, value: id);
  }
}
