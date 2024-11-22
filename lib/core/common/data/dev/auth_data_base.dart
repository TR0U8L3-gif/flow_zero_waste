// ignore_for_file: public_member_api_docs

import 'package:flow_zero_waste/core/services/hive/hive_manager.dart';

const userKey = 'userAuth';
const currentUserKey = 'userAuthCurrent';
const userBoxName = 'userAuthBox';
const currentUserBoxName = 'currentUserAuthBox';

class UserAuthHiveStorage extends HiveManager<String> {
  UserAuthHiveStorage({required super.boxName});
}

class CurrentUserAuthHiveStorage extends HiveManager<String> {
  CurrentUserAuthHiveStorage({required super.boxName});
}
