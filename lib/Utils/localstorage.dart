import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LocalStorage {

  Future store(String key, dynamic data) async {
    var _appStore = StoreRef.main();
    _appStore.record(key).put(await _getDatabase(), data);
  }

  Future fetch(String key) async {
    var _appStore = StoreRef.main();

    var res = await _appStore.record(key).get(await _getDatabase());
    return res;
  }

  Future delete(String key) async {
    var _appStore = StoreRef.main();

    var res = await _appStore.record(key).delete(await _getDatabase());
    return res;
  }

  Future<Database> _getDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = "${dir.path}/darl_dispatch.db";

    DatabaseFactory factory = databaseFactoryIo;

    Database db = await factory.openDatabase(dbPath);
    return db;
  }
}
