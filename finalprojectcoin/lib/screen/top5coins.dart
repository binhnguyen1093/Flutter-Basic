import 'package:finalprojectcoin/model/coin_entity.dart';
import 'package:finalprojectcoin/repository/coin_repository.dart';
import 'package:finalprojectcoin/screen/coin_item_widget.dart';
import 'package:flutter/material.dart';

class Top5Coins extends StatefulWidget {
  const Top5Coins({Key? key}) : super(key: key);

  @override
  State<Top5Coins> createState() => _Top5CoinsState();
}

class _Top5CoinsState extends State<Top5Coins> {
  List<CoinEntity> listTop5Coins = [];

  @override
  void initState() {
    super.initState();
    List<CoinEntity> listCoinSort = [];
    listCoinSort.addAll(CoinRepository.listCoin);
    listCoinSort.sort((a, b) => (b.priceChangePercentage24h ?? 0)
        .compareTo((a.priceChangePercentage24h ?? 0)));
    listTop5Coins.addAll(listCoinSort.take(5));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildListTop5Coins(),
    );
  }

  buildListTop5Coins() => ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 7),
      itemBuilder: (BuildContext context, int index) {
        CoinEntity item = listTop5Coins[index];
        return CoinItemsWidget(item);
      },
      itemCount: listTop5Coins.length);
}
