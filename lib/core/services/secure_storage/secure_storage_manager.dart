import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// SecureStorageManager is a class that manages the secure storage for the app.
abstract class SecureStorageManager {

  /// Account name for the secure storage
  static const accountName = 'flutter_secure_storage_new_service';
  
  /// Get the ios options
  static IOSOptions get iosOptions {
    return const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      accountName: accountName,
    );
  }

  /// Get the android options
  static AndroidOptions get androidOptions {
    return  const AndroidOptions(encryptedSharedPreferences: true);
  }

  /// Get the secure storage instance
  static FlutterSecureStorage get storage {
    return FlutterSecureStorage(
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }
}
