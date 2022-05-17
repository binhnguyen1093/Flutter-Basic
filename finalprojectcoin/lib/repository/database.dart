// database.dart
import 'dart:async';

import 'package:finalprojectcoin/model/coin_entity.dart';
import 'package:finalprojectcoin/repository/coindao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [CoinEntity])
abstract class AppDatabase extends FloorDatabase {
  CoinDao get coinDao;
}
