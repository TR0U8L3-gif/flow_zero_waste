import 'package:flow_zero_waste/core/services/secure_storage/secure_storage_manager.dart';
import 'package:injectable/injectable.dart';

/// SecureStorageImplementation is a class that implements 
/// the secure storage for the app.
@Singleton(as: SecureStorageManager)
class SecureStorageImplementation extends SecureStorageManager {}
