// dao/person_dao.dart

import 'package:finalprojectcoin/model/coin_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class CoinDao {
  @Query('SELECT * FROM CoinEntity')
  Future<List<CoinEntity>> findAllCoin();

  @Query('SELECT * FROM CoinEntity WHERE id = :id')
  Future<CoinEntity?> findCoinId(String id);

  @insert
  Future<void> insertCoin(CoinEntity person);

  @delete
  Future<void> deleteCoin(CoinEntity person);
}
