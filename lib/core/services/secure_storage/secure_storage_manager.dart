import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageManager {
  
  static const accountName = 'flutter_secure_storage_new_service';

  static IOSOptions get iosOptions {
    return const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      accountName: accountName,
    );
  }

  static AndroidOptions get androidOptions {
    return  const AndroidOptions(encryptedSharedPreferences: true);
  }

  static FlutterSecureStorage get storage {
    return FlutterSecureStorage(
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }
}