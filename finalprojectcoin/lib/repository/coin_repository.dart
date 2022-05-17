import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dio/dio.dart';
import 'package:finalprojectcoin/model/coin_entity.dart';
import 'package:finalprojectcoin/repository/coindao.dart';
import 'package:finalprojectcoin/repository/database.dart';

import '../model/chart_entity.dart';

class CoinRepository {
  static List<CoinEntity> listCoin = [];
  static CoinDao? coinDao;

  void iniDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    coinDao = database.coinDao;
  }

  Future<List<CoinEntity>?> getListFavorite() async {
    return await coinDao?.findAllCoin();
  }

  Future<bool> isFavorite(String? coinId) async {
    final isCheck = await coinDao?.findCoinId(coinId ?? '');
    return isCheck != null;
  }

  void addFavorite(CoinEntity coinEntity) {
    coinDao?.insertCoin(coinEntity);
  }

  void removeFavorite(CoinEntity coinEntity) {
    coinDao?.deleteCoin(coinEntity);
  }

  Future<List<CoinEntity>> getListCoinTop100() async {
    try {
      var response = await Dio().get(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false');
      listCoin.addAll(List<CoinEntity>.from(
          (response.data).map((e) => CoinEntity.fromJson(e))));
      return listCoin;
    } catch (e) {
      print(e);
      return List<CoinEntity>.empty();
    }
  }

  Future<List<charts.Series<ChartEntity, DateTime>>> getChart(
      String id, int hour) async {
    String from = (DateTime.now()
                .subtract(Duration(hours: hour))
                .toUtc()
                .millisecondsSinceEpoch /
            1000)
        .round()
        .toString();
    String to = (DateTime.now().toUtc().millisecondsSinceEpoch / 1000)
        .round()
        .toString();
    final response = await Dio().get(
        'https://api.coingecko.com/api/v3/coins/$id/market_chart/range?vs_currency=usd&from=$from&to=$to');
    List<ChartEntity> listChart = [];
    await jsonDecode(response.toString())['prices'].forEach((element) {
      listChart.add(ChartEntity(
          prices: element[1].toString(),
          time: DateTime.fromMicrosecondsSinceEpoch(element[0])));
    });

    return Future.value([
      charts.Series<ChartEntity, DateTime>(
        id: 'ChartCoin',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (ChartEntity chart, _) => chart.time ?? DateTime.now(),
        measureFn: (ChartEntity chart, _) => num.parse(chart.prices ?? "0"),
        data: listChart,
      )
    ]);
  }
}
